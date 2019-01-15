echo test

#Set vim-like keybindings in the terminal
set -o vi

#Make homeshick work
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

#Setup git completion
if [ -f $HOME/.homesick/repos/dotfiles/.git-completion.bash ]; then
	. $HOME/.homesick/repos/dotfiles/.git-completion.bash
fi
