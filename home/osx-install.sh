# Getting homebrew installed and set up to use
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH=$PATH:/opt/homebrew/bin/

# Installing oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Getting configuration files and setting them up to have the machine work more powerfully
brew install homeshick
homeshick clone https://github.com/Nnoerregaard/dotfiles.git 

# Installing essential utility stuff
brew install gh
brew install tmux
brew install tmuxinator

# Installing editor and setting it up
brew install nvim
brew install ag
brew install yarn
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
pip3 install --upgrade pip
pip3 install --upgrade pynvim
nvim --headless +PlugInstall +qall

# Setting up GitHub access and cloning relevant projects 



echo "Please be aware that you will have to manually change CAPS LOCK to map to CTRL to get the keybindings you are used to. Also, be aware that you might have to download and install python manually!"
