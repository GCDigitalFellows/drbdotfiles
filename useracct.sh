#!/bin/bash
#
# Creates a new user account named "$USERNAME" in the standard users group

USERNAME=student

# Uncomment the next two lines to use this as a startup script, and remove the "sudos" from subsequent lines
# . /etc/rc.common
# dscl . create /Users/$USERNAME
say "Password"
sudo dscl . create /Users/$USERNAME RealName "$USERNAME"
sudo dscl . create /Users/$USERNAME hint "$USERNAME"
sudo dscl . passwd /Users/$USERNAME $USERNAME
MAXID=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -ug | tail -1)
USERID=$((MAXID+1))
sudo dscl . create /Users/$USERNAME UniqueID $USERID
sudo dscl . create /Users/$USERNAME PrimaryGroupID 20
sudo dscl . create /Users/$USERNAME UserShell /bin/bash
sudo dscl . create /Users/$USERNAME NFSHomeDirectory /Users/$USERNAME
sudo cp -R /System/Library/User\ Template/English.lproj /Users/$USERNAME
# sudo createhomedir -u $USERNAME
cd /Users/$USERNAME
sudo git clone https://github.com/GCDigitalFellows/drbdotfiles.git .dotfiles
cd .dotfiles
sudo git submodule init
sudo git submodule update
sudo ln -s /Users/$USERNAME/.dotfiles/home/profile /Users/$USERNAME/.profile
cd /Users/$USERNAME
sudo chown -R $USERNAME:staff /Users/$USERNAME
sudo dscl . create /Users/$USERNAME picture "/Users/$USERNAME/.dotfiles/gcdilogo.png"
