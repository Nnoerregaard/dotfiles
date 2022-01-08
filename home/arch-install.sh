# Update pacman
pacman -Sy

# Install git
pacman -Sy git

# Install yay
pacman -Sy base-devel
pacman -Sy go
cd /opt
git clone https://aur.archlinux.org/yay.git
useradd -m -s /bin/bash niklas
chown niklas yay/
su niklas
cd yay
makepkg -si
exit
