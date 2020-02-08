
################################################################################
# Colors
################################################################################

# http://bashrcgenerator.com/
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PS1="\[$(tput sgr0)\]\[\033[38;5;6m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\\$ \[$(tput sgr0)\]"

# syntax colors for less, replace cat
# https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --window=-4'
# brew install less
# https://unix.stackexchange.com/questions/107315/less-quit-if-one-screen-without-no-init/432254#comment784324_432254

# Set colors for less. Borrowed from https://wiki.archlinux.org/index.php/Color_output_in_console#less .
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# git clone https://github.com/wofr06/lesspipe.git
# cd lesspipe/ && ./configure && code code2color && cp lesspipe.sh code2color /usr/local/bin
if type lesspipe.sh >/dev/null 2>&1; then
	export LESSOPEN='|lesspipe.sh %s'
fi

# sudo pip install Pygments
# if type pygmentize >/dev/null 2>&1; then
# 	export LESSCOLORIZER='pygmentize'
# fi

################################################################################
# Improve bash
################################################################################

# case insensitive autocomplete
# https://askubuntu.com/questions/87061/can-i-make-tab-auto-completion-case-insensitive-in-bash
bind 'set completion-ignore-case on'

# cd autocomplete on directories only
complete -d cd

alias cp='cp -i'                           # Preferred 'cp' implementation
alias mv='mv -i'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                    # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                      # Preferred 'ls' implementation

# ~/.inputrc

################################################################################
# Aliases
################################################################################

export GREP_OPTIONS='--color=auto'
export bp='/Users/BlueTyphoid/.bash_profile'

alias path='echo -e ${PATH//:/\\n}'

alias chrome='open -a "Google Chrome"'
alias slack='open /Applications/Slack.app/'
alias notes='code ~/r/notes'
alias lg='code ~/r/log'

# https://github.com/arduino/Arduino/blob/master/build/shared/manpage.adoc
alias arduino='/Applications/Arduino-1.8.10.app/Contents/MacOS/Arduino'
alias arduino_upload='echo "arduino --upload GettingStarted.ino --port /dev/cu.usbserial-D306LM9C"'
alias mysqlr='mysql -uroot -ppassword'
alias vba='. venv/bin/activate'
alias puml='java -jar /Users/BlueTyphoid/dev/puml/plantuml.jar '


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
		PATH="$HOME/bin:$PATH"
fi

################################################################################
# Git
################################################################################

# display branch name
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# git autocomplete https://apple.stackexchange.com/a/55886
if [ -f ~/.git-completion.bash ]; then
	. ~/.git-completion.bash
fi

alias ga='git add'
alias gaa='git add --all'
alias gb='git branch -vv --sort=-committerdate --color=always'
alias gd="git diff -w --word-diff=color -U0 | sed -e '/+++.*/d' | sed -e '/---.*/d' | sed -e '/index .*/d' | sed -e 's/diff --git a\/\(.*\) b\/.*/\1/'"
alias gk='gitk&'
alias gl='git log --pretty=oneline --abbrev-commit --color=always --decorate | head -5'
alias gll='git log --all --decorate --oneline --graph'
alias gm='git commit -m'
alias gp='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gr='git remote -v'
alias gs='git status -s'
alias gsa='git log --color --graph --oneline | cat | head -5 && git diff --stat && git status -bs'

alias github='chrome $(git config --get remote.origin.url | sed s/\\.git//)/commits/$(git rev-parse --abbrev-ref HEAD)'

################################################################################
# Functions
################################################################################

function pup {
	rm electron_firmware_*
	particle serial flash $(ls | grep electron)
}

function ports {
	arr=($(ls /dev | grep cu.usb))  # https://stackoverflow.com/a/13824135
	for i in ${!arr[@]}; do         # https://stackoverflow.com/a/6723516
		echo "$i    screen /dev/${arr[$i]} 115200"
	done
	if [[ -n $1 ]]; then            # https://serverfault.com/a/382740
		echo ${arr[$1]}
		sleep 1
		"$(screen /dev/${arr[$1]} 115200)"
	fi
}

function upload_electron {
	# cmd="particle serial flash $(ls -t | grep electron_firmware | head -1)"
	# echo $cmd
	# eval $cmd
	echo "particle compile electron"
	particle compile electron
	file="$(ls -t | grep electron_firmware | head -1)"

	echo "particle usb dfu"
	particle usb dfu
	sleep 1

	echo "particle flash --usb $file"
	particle flash --usb $file
	sleep 2
	
	ports
	# particle serial monitor
}
alias grepless='sh ~/scripts/grepless.sh'
alias search='sh ~/scripts/search.sh'
alias mysqlr='mysql -uroot -ppassword'

alias notes='code ~/notes'
alias lg='code ~/log'

alias chrome='open -a "Google Chrome"'
alias gmail='open -a "Google Chrome" https://www.gmail.com/'
alias drive='open -a "Google Chrome" https://drive.google.com/'
alias maps='open -a "Google Chrome" https://maps.google.com/'
