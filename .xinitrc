#!/bin/sh

####################################################################
  # File Name: .xinitrc
  # Purpose: Start up the Xorg server.
  # Creation Date: 19-07-2015
  # Last Modified: Sat Sep 06 09:27:12
  # Created By: Ivan Guerra <Ivan.E.Guerra-1@ou.edu>
####################################################################

# Set some script varables
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Load some scripts from <xinitrc.d> specifically <30-dbus.sh>
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Source <~/.xprofile> in order shutoff PC speaker beeping
[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

# Disable the system bell
xset -b

# Enable the left pointer cursor rather than the default X cursor when using xmonad
xsetroot -cursor_name left_ptr

# Set the background
feh --bg-scale /home/ieg/pictures/mountains.jpg &

# Start the xmonad tiled window manager
exec xmonad
