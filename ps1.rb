#!/usr/bin/env ruby

=begin
	Setup:
		1. make this script executable
				# chmod 755 ps1.rb

		2. create a symlink
				# ln -s /path/to/ps1.rb /path/to/symlink/rubyps1

		3. make sure the link is in the path if it isn't already
				# PATH=$PATH:/path/to/symlink

		4. add this code to .bashrc
				function _update_ps1() {
					PS1="$(rubyps1 $?)"
				}

				if [ "$TERM" != "linux" ]; then
					PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
				fi

		5. source .bashrc
				# . ~/.bashrc
=end

require_relative "segments"

class Prompt
	extend Segments

	def get_options()
	 	{
			:opts => [:username, :hostname, :cwd, :git, :prompt],
			:rules => {}
		}
	end


	def generate_ps1(exit_status = 0)
		config = get_options
		opts = config[:opts]
		rules = config[:rules]
		start = Time.now

		ps1 = ""
		ps1_hash = {}
		cmd_args = {
			:exit_status => exit_status,
			:prompt => exit_status
		}

		opts.each { |opt|
			args = []
			args << cmd_args[opt] if cmd_args.key? opt
			val = Segments::call_method(opt, args)
			ps1 << val
		}

		# reset colour at the end of the string
		ps1 << Segments::end_prompt

		ps1 = "🌀  [#{"%i" % ((Time.now - start)*1000000)}]" + ps1

		Segments::replace_colours(ps1)
	end
end

if __FILE__ == $0
	begin
		ps1 = Prompt.new
		puts ps1.generate_ps1 ARGV[0]
	rescue SystemExit, Interrupt
		exit 1
	end
end