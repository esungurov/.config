#!/bin/sh

## Enable Starship prompt
 
 eval "$(starship init zsh)"

## Some useful options (man zshoptions)
  
  setopt autocd extendedglob nomatch menucomplete
  setopt interactive_comments
  #zle_highlight=('paste:none')

## Add notifications for terminal

  notify(){
    osascript -e 'display notification "Job Done!" with title "Terminal" sound name "Ding"'
  }

# Completions

## zsh-completions

  if type brew &>/dev/null
  then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

    autoload -Uz compinit
    compinit
  fi
  
  zstyle ':completion:*' menu select
  zmodload zsh/complist
  #_comp_options+=(globdots)		# Include hidden files.

## Completions for Terraform
  
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /usr/local/bin/terraform terraform

## Completions for Ansible

  #eval "$(register-python-argcomplete ansible)"
  #eval "$(register-python-argcomplete ansible-config)"
  #eval "$(register-python-argcomplete ansible-console)"
  #eval "$(register-python-argcomplete ansible-doc)"
  #eval "$(register-python-argcomplete ansible-galaxy)"
  #eval "$(register-python-argcomplete ansible-inventory)"
  #eval "$(register-python-argcomplete ansible-playbook)"
  #eval "$(register-python-argcomplete ansible-pull)"
  #eval "$(register-python-argcomplete ansible-vault)"

# Aliases
## Colorize grep output (good for log files)
  
  alias grep='grep --color=auto'
  alias egrep='egrep --color=auto'
  alias fgrep='fgrep --color=auto'

## Confirm before overwriting something
  
  alias cp="cp -i"
  alias mv='mv -i'
  alias rm='rm -i'

## Easier to read disk
  
  alias df='df -h'                          # human-readable sizes

## Get top process eating memory
  
  alias psmem='ps -auroot | sort -nr -k 4 | head -5'

## Get top process eating cpu
  
  alias pscpu='ps -auroot | sort -nr -k 3 | head -5'

## ls
  
  alias ls="ls -G"
  alias ll="ls -laG"

## Get your public IP from ipinfo.io

  alias myip="curl http://ipinfo.io/json"

## Fix Midnight Commander slow start

  alias mc='mc -u'

# Plugins (Installed with homebrew)

  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Python pyenv config

  if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
  fi
  export PATH="$PATH:/Users/esungurov/.local/bin"

# Python virtual env activation (Slows down prompt)

  eval "$(pyenv virtualenv-init -)"
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Golang PATH

  export GOPATH=$HOME/go
  export GOROOT="$(brew --prefix golang)/libexec"
  export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
