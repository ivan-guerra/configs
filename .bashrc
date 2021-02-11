# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set the command prompt line title to display the working directory (short form)
PS1='\W :: '

# Set the umask to NSA RHEL5 recommended
umask 077

# Restrict use of shell commands when editing in nano using <sudoedit>
export SUDO_EDITOR=vim

# Misc commands
alias getwifi="sudo wifi-menu wlp2s0"
alias ls='ls --color=auto'
alias ll='ls -la'
alias cp='rsync -ah --progress'
alias pdf='apvlv'
alias tr='tree -CL 2'
alias rkh='sudo rkhunter -c --sk'       # Allow rkhunter to scan the filesystem
alias rkupg='sudo rkhunter --propupd'   # Allow rkhunter to update its DB
alias ddir='cd /home/ieg/downloads'

# Display adjustment
alias setmon='xrandr --output HDMI1 --primary --auto --right-of LVDS1 --output LVDS1 --off'
alias resetmon='xrandr --auto'

# Video editing

## Mount a USB device to /mnt/usb.
## $1 - Device name excluding the /dev/ prefix.
mountusb() {
  sudo mount -o gid=ieg,fmask=113,dmask=002 /dev/$1 /mnt/usb
}
alias umountusb='sudo umount /mnt/usb'

## Play a video with ffplay and include a timestamp box in HH:MM:SS format.
## $1 - Path to the movie file.
playmovie() {
  ffplay -vf "drawtext=text='%{pts\:hms}':box=1:x=(w-tw)/2:y=h-(2*lh)" $1
}

## Cut the input video from some start time to some end time.
## $1 - Input video file name with the extension included.
## $2 - Output video file name with the extension included.
## $3 - Snippet start time in HH:MM:SS format.
## $4 - Snippet end time in HH:MM:SS format.
trimmovie() {
  ffmpeg -i $1 -ss $3 -to $4 -c:v copy -c:a copy $2
}

# Dev commands
alias taggen='ctags -R *'
alias cpp='g++ -g -std=c++11 -Werror'
alias val='valgrind --leak-check=yes --track-origins=yes'

# Navigation commands
alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias dev='cd ~/dev'
alias ddir='cd ~/downloads'

# Fetch time/date info
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# Set Vim as the default editor
alias vi=vim
alias svi='sudo vi'
alias vis='vim "+set si"'
alias edit='vim'

# Modified ping commands
# Stop after sending count ECHO_REQUEST packets
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast
alias fastping='ping -c 100 -s.2'

# Reboot/halt the machine
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'

# System memory and GPU usage info
alias meminfo='free -m -l -t'
# Get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
# Get GPU RAM on desktop/laptop
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

# Useful command aliases for managing the system using pacman (the Arch package manager)
alias pacupg='sudo pacman -Syu'		# Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacdl='pacman -Sw'		      # Download specified package(s) as .tar.xz ball
alias pacin='sudo pacman -S'		  # Install specific package(s) from the repositories
alias pacins='sudo pacman -U'		  # Install specific package not from the repositories but from a file
alias pacre='sudo pacman -R'		  # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'		# Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'		      # Display information about a given package in the repositories
alias pacreps='pacman -Ss'		    # Search for package(s) in the repositories
alias pacloc='pacman -Qi'		      # Display information about a given package in the local database
alias paclocs='pacman -Qs'		    # Search for package(s) in the local database
alias paclo="pacman -Qdt"		      # List all packages which are orphaned
alias pacc="sudo pacman -Scc"		  # Clean cache - delete all the package files in the cache
alias paclf="pacman -Ql"		      # List all files installed by a given package
alias pacown="pacman -Qo"		      # Show package(s) owning the specified file(s)
alias pacexpl="pacman -D --asexp"	# Mark one or more installed packages as explicitly installed
alias pacimpl="pacman -D --asdep"	# Mark one or more installed packages as non explicitly installed
alias pacprint="pacman -Qen"		  # Print a list of installed packages
alias pacprinta="pacman -Qem"		  # Print a list of packages installed from the AUR

# Activate colored manpages
man() {
    {
        env LESS_TERMCAP_mb=$'\E[01;31m' \
            LESS_TERMCAP_md=$'\E[01;38;5;74m' \
            LESS_TERMCAP_me=$'\E[0m' \
            LESS_TERMCAP_se=$'\E[0m' \
            LESS_TERMCAP_so=$'\E[38;5;246m' \
            LESS_TERMCAP_ue=$'\E[0m' \
            LESS_TERMCAP_us=$'\E[04;38;5;146m' \
            man "$@"
    }
}

# Locate and prompt to remove orphaned packages if any exists
orphans() {
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo "No orphans to remove."
    else
        sudo pacman -Rns $(pacman -Qdtq)
    fi
}
