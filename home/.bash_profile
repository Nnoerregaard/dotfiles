#Set vim-like keybindings in the terminal
set -o vi
bind '"jk":vi-movement-mode'

#Make homeshick work
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

#Setup git completion
if [ -f $HOME/.homesick/repos/dotfiles/.git-completion.bash ]; then
	. $HOME/.homesick/repos/dotfiles/.git-completion.bash
fi

#Make android work on the terminal. At the moment, I have surrendered to the convinience of using Android Studio
export ANDROID_SDK_ROOT=/Users/niklasnorregaard/Library/Android/sdk

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

export PATH="$HOME/.cargo/bin:$PATH"
