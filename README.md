# Void Linux essential config files

##  System information

```
OS: Void Linux
Shell: bash
DE: KDE Plasma 5
term: Alacritty
```
### Last update: 14 Mar 2019

My current /home/user tree looks like this
```
/home/kbaran
├── bin
├── etc
├── src
├── usr
└── var
5 directories, 0 files
```

* `bin` - personal scripts, directory appended to ```$PATH``` 
* `etc` - storing config files that are symlinked to ```/home/user``` and other locations
* `src` - directory for source files, I'm using it to store various scripts, sorted by language
* `usr` - personal files like images, music, scrots and other
* `var` - directory used to sort files to other destinations

## Bash setup
I'm using bash as my shell with basic prompt colors and git status prompt when cd'd into a directory with .git file in it.

Bash completion is tweaked in `.inputrc` file, prompt template for normal directories is stored in `.bashrc` as `export PS1="..."`.
I'm using [bash-git-prompt](https://github.com/magicmonty/bash-git-prompt) for git repositories:

* `.git-prompt-colors.sh` stores the very basic git prompt I've tweaked a little bit (color stuff)
* `.bash-git-prompt/` is the main directory of bash-git-prompt, containing themes and various scripts managing the overall look of the prompt, symlinked to `$HOME`

I've sourced `.bash-git-prompt/gitprompt.sh` and `.bash-git-prompt/prompt-colors.sh` in `.bashrc` so the prompt actually knows how to run and look like.

`bash-completion` is installed to enable git commands autocompletion. It is sourced in `.bashrc` as well.
