# Update pacman
pacman -Sy

# Install git to do setup and also just for general development
pacman -Sy git
# Install sudo to check the validity of the sudoer file after modification
pacman -Sy sudo
# Install sed to modify the sudoer file (and other files) in a non-interactive way
pacman -Sy sed

# Add user that can work with sudo
useradd -m -G wheel -s /bin/bash niklas
passwd niklas
# NB! This line has been known to change across different versions of Arch. If you get an 
# erro about the user not being in sudoers, check the file manually.
# This line number should work with the Arch version that is used in the Arch Linux
# docker image with image ID 1105a6ef0052. Other known line numbers to work include 85
sed -i '89s/# //g' /etc/sudoers # Add wheel users with passwords to sudoers 
visudo -c # Check that the sudoers file is still valid

# Install yay to access all community packages
pacman -Sy base-devel
pacman -Sy go
cd /opt
# git clone https://aur.archlinux.org/yay-bin.git
git clone https://aur.archlinux.org/yay.git
chown niklas yay/
su niklas
cd yay
git config --global --add safe.directory /opt/yay
makepkg -si

# Go home again
cd ~

# Update all packages using yay
# yay -Syu --devel --timeupdate

# Install pinentry to remember the lastpass master password
yay -Sy pinentry

# Intall lastpass and lastpass CLI to be able to access password and access tokens
yay -Sy lastpass-cli # Maybe we need to install lastpass as well but I'm not sure

# We need to be root in order to login to lastpass and use it
exit
lpass login niklas.noerregaard@gmail.com

# Generate SSH key to be able to work with SSH later on. Maybe, we should wait until we actually need it
yay -Sy openssh
ssh-keygen -t ed25519 -C "niklas@themossconcept.com"
eval "$(ssh-agent -s)"

# Install GitHub CLI and authenticate to gain access to your repos including your dotfiles
yay -Sy github-cli
lpass show --notes 5561560319192977980 | gh auth login --with-token

# Intall homeshick to access your configuration files
su niklas
yay -Sy homeshick-git

# Since we are doing the cloning and linking in root, 
# we need to be in root to access the files in homeshick
# which I'm not sure is what we want
homeshick clone Nnoerregaard/dotfiles
homeshick link

yay -Sy zsh
curl -L http://install.ohmyz.sh | sh

# Use zsh instead of bash
zsh

# Set up node (needed for neovim)
yay -Sy nvm
source /usr/share/nvm/init-nvm.sh # Consider putting this in the .zshrc so it's always sourced
nvm install --lts
npm install -g neovim

# Set up Python (needed for neovim)
yay -Sy python-pynvim

# Set up Ruby (needed for neovim)
yay -Sy ruby-neovim

# Set up perl (needed for neovim)
yay -Sy perl

# Set up tmux which also includes clipboard tools
yay -Sy tmux 

# This is to make VimPlug work.
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Set up neovim
yay -Sy neovim
# Remember to run PlugInstall and CocInstall on the first neovim run. This hasn't been tested yet!
nvim --headless +PlugInstall +CocInstall +q  
export EDITOR=nvim


