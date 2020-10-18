# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# Load git completion functionality
if [[ `uname` == 'Darwin' ]]; then
  # Use MacVim in terminal mode instead of builtin Vim in order to get +conceal.
  alias ls='ls -AFpG'
  alias ll='ls -l'

  source ~/dotfiles/git-completion.bash
  source ~/dotfiles/git-prompt.sh
  export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
else
  source ~/dotfiles/git-completion.bash
  source ~/dotfiles/git-prompt.sh

  # Show colorized output, show all files except "." and ".." and add a slash at
  # the end of directory names
  alias ls='ls -ApG --color=auto'

  alias ll='ls -l'

  eval `dircolors ~/dotfiles/.dir_colors`

  SSH_ENV="$HOME/.ssh/environment"

  function start_agent {
       echo "Initialising new SSH agent..."
       /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
       echo succeeded
       chmod 600 "${SSH_ENV}"
       . "${SSH_ENV}" > /dev/null
       /usr/bin/ssh-add;
  }

  # Source SSH settings, if applicable

  if [ -f "${SSH_ENV}" ]; then
       . "${SSH_ENV}" > /dev/null
       #ps ${SSH_AGENT_PID} doesn't work under cywgin
       ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
           start_agent;
       }
  else
       start_agent;
  fi
fi

# Don't show duplicated entries when using 'history' command.
export HISTCONTROL=erasedups

export EDITOR=vim

# Store up to 50k entries in history
export HISTSIZE=50000

export HISTTIMEFORMAT="%Y%m%d %H:%M:%S "

export JAVA_HOME=/Library/Java/Home

# http://superuser.com/questions/180257/bash-prompt-how-to-have-the-initials-of-directory-path
function shorten_pwd {
    # This function ensures that the PWD string does not exceed $MAX_PWD_LENGTH characters
    PWD=$(pwd)

    # if truncated, replace truncated part with this string:
    REPLACE="/.."

    # determine part of path within HOME, or entire path if not in HOME
    RESIDUAL=${PWD#$HOME}

    # compare RESIDUAL with PWD to determine whether we are in HOME or not
    if [ X"$RESIDUAL" != X"$PWD" ]
    then
        PREFIX="~"
    fi

    # check if residual path needs truncating to keep total length below MAX_PWD_LENGTH
    # compensate for replacement string.
    TRUNC_LENGTH=$(($MAX_PWD_LENGTH - ${#PREFIX} - ${#REPLACE} - 1))
    NORMAL=${PREFIX}${RESIDUAL}
    if [ ${#NORMAL} -ge $(($MAX_PWD_LENGTH)) ]
    then
        newPWD=${PREFIX}${REPLACE}${RESIDUAL:((${#RESIDUAL} - $TRUNC_LENGTH)):$TRUNC_LENGTH}
    else
        newPWD=${PREFIX}${RESIDUAL}
    fi

    # return to caller
    echo $newPWD
}

# Show short bash prompt. Change the last digit of 1;34 to change colors (it
# goes from 0 up to 7).
# Set a custom prompt color with:
# PS_MODE=1
# Meaningful values for solarice theme: 1 to 8
SLNC_PS1_COLOR=${SLNC_PS1_COLOR:=8}
export PS1='\[\033[0;3${SLNC_PS1_COLOR}m\]\t \[\033[0;38m\]$(shorten_pwd)\[\033[1;32m\]$(__git_ps1 " (%s)")\[\033[0m\] '

# The history list is appended to the history file when the shell exits,
# rather than overwriting the history file.
shopt -s histappend

# Shortcut for list mode (my default).
MAX_PWD_LENGTH=20

alias cdgm="cd /srv/www/gamersmafia/current"
alias rtest="ruby -Itest"

function last_modified_file {
  local last=`find $1 -type f -printf "%T@\0%p\0" | awk '
       {
           if ($0>max) {
               max=$0;
               getline mostrecent
           } else
               getline
       }
       END{print mostrecent}' RS='\0'`
  ll $last
}

export SLNC_PS1_COLOR=3

export PORT=80

export TERM=xterm-256color
alias c='cd ..'
alias cdapi='cd ~/Work/dev/lightning-api'
alias cdclient='cd ~/Work/dev/lightning-client'
alias cdinternal='cd ~/Work/dev/lightning-internal'
alias cddev='cd ~/Work/dev'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### For GCC ###
alias gccrun="function gccrun() {
  gcc $1 -o /tmp/gccrun
  /tmp/gccrun
}"
export PATH=$PATH:~/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

alias loadenv='export $(grep -v "^#" .env | xargs)'


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/phidang/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/phidang/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/phidang/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/phidang/Downloads/google-cloud-sdk/completion.bash.inc'; fi

# Google Speech2Text
export GOOGLE_APPLICATION_CREDENTIALS="/Users/phidang/Work/BillieJean-4caf4607ee10.json"
