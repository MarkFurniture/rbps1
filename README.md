## RubyPS1

Ruby implemented dynamic PS1 prompt for bash, inspired by [powerline-shell](https://github.com/b-ryan/powerline-shell).

###### Why not powerline-shell?
1. Primarily, pedagogy.
2. I only have need of a subset of powerline-shell's functionality, and wanted to run a performant PS1 prompt without requiring a daemon in the background. Running powerline-shell without a daemon is subject to python's startup time and performs IO that is superfluous to my needs, hence this simplified version.

###### Installation:

1. Clone this repo:
```
$ git clone https://github.com/MarkFurniture/rbps1.git
```
2. Make sure ps1.rb is in the PATH:
```
$ cd rbps1
$ ln -s ./ps1.rb  /usr/local/bin/rubyps1/rubyps1
```
3. Make sure ps1.rb is executable:
```
$ chmod +x ps1.rb
```
4. Add to ~/.bashrc or ~/.bash_profile:
```
function _update_ps1() {
    PS1="$(rubyps1 $?)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1"
fi
```
5. Source ~/.bashrc or ~/.bash_profile or restart your shell:
```
$ . ~/.bashrc
```
