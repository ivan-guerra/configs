# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Enable GCC6
source scl_source enable devtoolset-6

# Set the prompt
PS1='[\W] '

# Command aliases

# Misc commands
alias ls='ls --color=auto'
alias ll='ls -la'
alias pdf='evince'
alias tr='tree -CL 2'
alias bc='bc -l'
alias h='history'
alias mkdir='mkdir -pv'

# Dev commands
alias taggen='ctags -R *'
alias cpp='g++ -g -std=c++11 -Werror'
alias val='valgrind --leak-check=yes --track-origins=yes'

## Navigation commands
alias ..='cd ..'
alias ....='cd ../../'
alias ......='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias dev='cd ~/dev'
alias ddir='cd ~/downloads'

## Fetch time/date info
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

## Set Vim as the default editor
alias vi=vim
alias svi='sudo vi'
alias vis='vim "+set si"'
alias edit='vim'

## Modified ping commands
### Stop after sending count ECHO_REQUEST packets
alias ping='ping -c 5'
### Do not wait interval 1 second, go fast
alias fastping='ping -c 100 -s.2'

## Reboot/halt the machine
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'

## System memory and GPU usage info
alias meminfo='free -m -l -t'
### Get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
### Get GPU RAM on desktop/laptop
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
