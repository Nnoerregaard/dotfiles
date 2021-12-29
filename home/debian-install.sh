apt update

# Git
apt install -y git

# Curl
apt install -y curl

# ZSH
apt install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)

# Neovim
apt install -y neovim
apt install -y python3-neovim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# Tmux
apt install -y tmux
apt install -y tmuxinator

# Nvm and node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
[ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"  # This loads nvm
nvm install 16.13.1

# Expo
npm install -g expo

# LastPass CLI
sudo apt install -y lastpass-cli
lpass login --trust niklas.noerregaard@gmail.com

# GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
gh config set -h github.com git_protocol ssh

# Login to GitHub CLI using information from lastpass  
lpass show --sync=now "Github PAT" | grep Notes | sed s/Notes:\ // | gh auth login --with-token

# Generate SSH key
ssh-keygen -t ed25519 -C "Ubuntu PC"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

gh ssh-key add ~/.ssh/id_ed25519.pub

# Homeshick and configuration. Make sure this comes last!
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
homeshick clone git@github.com:Nnoerregaard/dotfiles.git
homeshick link

echo "Congratulations! Your new Debian based machine should now be set up and ready to go. Restart your terminal to start enjoying your new development environment"
