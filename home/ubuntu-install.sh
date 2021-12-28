apt update

# ZSH
apt install -y zsh

# Neovim
apt install -y neovim
apt install -y python-neovim
apt install -y python3-neovim

# Tmux
apt install -y tmux
apt install -y tmuxinator

# Nvm and node
apt install -y curl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
nvm install 16.13.1
