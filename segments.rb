module Segments
	def self.call_method(method, args)
		args.size > 0 ? self.send(method, args) : self.send(method)
	end

	def self.colour(fg, bg, txt)
		"\\[\\e[38;5;#{fg}m\\]\\[\\e[48;5;#{bg}m\\]#{txt}\\[\\e[48;5;#{bg}m\\]\\[\\e[38;5;#{fg}m\\]"
	end

	def self.default_colour(where)
		where == "fg" ? "\\[\\e[39m" : "\\[\\e[49m"
	end

	def self.reset_colour
		"\\[\\e[0m\\]"
	end

	def self.replace_colours(str)
		str.gsub(/\{f(\d+)\}/, "\\[\\e[38;5;\\1m\\]").gsub(/\{b(\d+)\}/, "\\[\\e[48;5;\\1m\\]")
	end

	def self.end_prompt
		"#{default_colour("bg")}#{reset_colour} "
	end

=begin
#############################################################################
# 																			#
# 							Add segments below								#
# 																			#
#############################################################################

		Characters:
			right chevron 	=> 
			right arrow 	=>      
		
		Colour format:
			f = foreground
			b = background
			number = colour
		Examples:
	 		{b240} => background colour 240
 			{f46}  => foreground colour 46
=end

	def self.username(args=nil)
		fg, bg = ENV['USER'] == "root" ? [255, 204] : [46, 240]

		"{f#{fg}}{b#{bg}} \\u {f#{bg}}"
	end

	def self.hostname(args=nil)
		fg, bg = ENV['USER'] == "root" ? [255, 204] : [46, 238]

		"{f#{fg}}{b#{bg}} \\h {f#{bg}}"
	end

	def self.cwd(args=nil)
		"{b31}{f255} #{Dir.pwd.gsub(/^#{Dir.home}/, "~")} {f31}"
	end

	def self.git(args=nil)
		git_str = Dir.exists?(".git") ? %x{git rev-parse --abbrev-ref HEAD 2> /dev/null}.strip : ""
		
		git_str.empty? ? "" : "{b220}{f0} #{git_str} {f220}"
	end

	def self.exit_status(status)
		status[0].to_s
	end

	def self.prompt(status=nil)
		prompt = ENV['USER'] == "root" ? "#" : "$"
		col = (status[0] == "0" ? 240 : 204)
		"{b#{col}}{f255} #{prompt} {f#{col}}"
	end
end


