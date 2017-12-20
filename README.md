Ruby implemented dynamic PS1 prompt for bash, inspired by powerline-shell.

Installation:

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
    PS1="$(/Users/mike/src/cpp/ps1/ps1 $?)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1"
fi
```
5. Source ~/.bashrc or ~/.bash_profile or restart your shell:
```
$ . ~/.bashrc
```
