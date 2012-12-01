export PATH=$PATH:~/bin

# Load git completion functionality
if [[ `uname` == 'Darwin' ]]; then
  # Use MacVim in terminal mode instead of builtin Vim in order to get +conceal.
  alias vim='mvim -v'
  alias ls='ls -ApG'
  alias ll='ls -l'

  source ~/core/dotfiles/git-completion.bash
  source ~/core/dotfiles/git-prompt.sh
  export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
else
  source /etc/bash_completion.d/git

  # Show colorized output, show all files except "." and ".." and add a slash at
  # the end of directory names
  alias ls='ls -ApG --color=auto'

  alias ll='ls -l'

eval `dircolors ~/dotfiles/.dir_colors`
fi

function parse_git_branch {
  local branch=$(__git_ps1 "%s")
  [[ $branch ]] && echo " ($branch)"
}

# Don't show duplicated entries when using 'history' command.
export HISTCONTROL=erasedups

export EDITOR=vim

# Store up to 50k entries in history
export HISTSIZE=50000

export HISTTIMEFORMAT="%Y%m%d %H:%M:%S "

export JAVA_HOME=/Library/Java/Home

# Show short bash prompt. Change the last digit of 1;34 to change colors (it
# goes from 0 up to 7).
export PS1='\t \w\[\033[1;32m\]$(parse_git_branch)\e[00m '

# The history list is appended to the history file when the shell exits,
# rather than overwriting the history file.
shopt -s histappend

# Shortcut for list mode (my default).

alias cdgm="cd /srv/www/gamersmafia/current"
alias rtest="ruby -Itest"
