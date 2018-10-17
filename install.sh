# ask for password upfront
sudo -v

#
# NVIM
#

# Installation
# checking if nvim is installaed
alias nvim >/dev/null 2>/dev/null
retVal=$?

NVIM_LOCATION=/opt/nvim.appimage

if [ $retVal -ne 0 ]; then
    wget https://github.com/neovim/neovim/releases/download/v0.3.1/nvim.appimage -O $NVIM_LOCATION 
    chmod u+x $NVIM_LOCATION
fi
