curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
export NVM_DIR="$HOME/.nvma"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm --version

#IN UBUNTU 18, Must Use node 17.xx.
nvm install 17 


echo '
parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1)/"
}
export PS1="\e[01;32m\u@\h \[\e[34m\]\w\[\e[33m\]\$(parse_git_branch)\[\e[00m\]$ "
c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`
branch_color () {
	if git rev-parse --git-dir >/dev/null 2>&1; then
		color=""
		if git diff --quiet 2>/dev/null >&2; then
			color="${c_green}"
		else
			color=${c_red}
		fi
	else
		return 0
	fi
	echo -ne $color
}
export PS1="\[\e[01;32m\]\u@\h \[\e[34m\]\w\[\${c_sgr0}\]\[\$(branch_color)\]\$(parse_git_branch)\[\${c_sgr0}\]\$ "' >> ~/.bashrc

#Need command source ~/.bashrc
