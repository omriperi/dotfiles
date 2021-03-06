# ask for password upfront
sudo -v


# Installing cargo for the-way installation
apt install cargo -y

# The Way Installation
# https://github.com/out-of-cheese-error/the-way
cargo install the-way

#
# NVIM
#

# Installation
# checking if nvim is installaed
alias nvim >/dev/null 2>/dev/null
retVal=$?

NVIM_LOCATION=/opt/nvim.appimage

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

if [ $retVal -ne 0 ]; then
    wget https://github.com/neovim/neovim/releases/download/v0.3.1/nvim.appimage -O $NVIM_LOCATION 
    chmod u+x $NVIM_LOCATION
fi

# VUNDLE
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# AG 
sudo apt install silversearcher-ag

# EXUBERANT CTAGS
sudo apt install exuberant-ctags
