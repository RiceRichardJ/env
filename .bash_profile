################################################################################
## DISPLAY GIT BRANCH NAME ON TERMINAL LINE

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

################################################################################
## TERMINAL COLORS
# http://bashrcgenerator.com/

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PS1="\[\033[38;5;2m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;5m\]\H\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;6m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\\$ \[$(tput sgr0)\]"

################################################################################
## CASE INSENSITIVE AUTOCOMPLETE
# https://askubuntu.com/questions/87061/can-i-make-tab-auto-completion-case-insensitive-in-bash

bind 'set completion-ignore-case on'

################################################################################
## GIT AUTOCOMPLETE

# https://apple.stackexchange.com/a/55886
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

################################################################################
## LESS SYNTAX COLORING

# https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/
# brew install less 
# https://unix.stackexchange.com/questions/107315/less-quit-if-one-screen-without-no-init/432254#comment784324_432254
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --window=-4'

# Set colors for less. Borrowed from https://wiki.archlinux.org/index.php/Color_output_in_console#less .
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# git clone https://github.com/wofr06/lesspipe.git
# cd lesspipe/
# ./configure
# cp lesspipe.sh code2color /usr/local/bin
# code /usr/local/bin/code2color
if type lesspipe.sh >/dev/null 2>&1; then
  export LESSOPEN='|lesspipe.sh %s'
fi

# sudo pip install Pygments
if type pygmentize >/dev/null 2>&1; then
  export LESSCOLORIZER='pygmentize'
fi

################################################################################
## ALIASES

export GREP_OPTIONS='--color=auto'
export bp='/Users/BlueTyphoid/.bash_profile'

alias path='echo -e ${PATH//:/\\n}'
alias github='chrome $(git config --get remote.origin.url | sed s/\\.git//)/commits/$(git rev-parse --abbrev-ref HEAD)'
alias grepless='sh ~/scripts/grepless.sh'
alias search='sh ~/scripts/search.sh'
alias mysqlr='mysql -uroot -ppassword'

alias notes='code ~/notes'
alias lg='code ~/log'

alias chrome='open -a "Google Chrome"'
alias gmail='open -a "Google Chrome" https://www.gmail.com/'
alias drive='open -a "Google Chrome" https://drive.google.com/'
alias maps='open -a "Google Chrome" https://maps.google.com/'
