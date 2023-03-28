# Getting homebrew installed and set up to use
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH=$PATH:/opt/homebrew/bin/

# Installing oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Installing essential stuff
brew install nvim
brew install homeshick
brew install gh

homeshick clone https://github.com/Nnoerregaard/dotfiles.git 
