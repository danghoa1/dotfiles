ln -s dotfiles/.dir_colors ~/
ln -s dotfiles/.gitconfig ~/
ln -s dotfiles/.inputrc ~/
ln -s dotfiles/.Rprofile ~/
ln -s dotfiles/.solarized ~/
ln -s dotfiles/.tmux.conf ~/
ln -s dotfiles/.vim ~/
ln -s dotfiles/.vimrc ~/
ln -s dotfiles/.xvimrc ~/

# Mac OS uses .profile instead of .bashrc
ln -s dotfiles/.bashrc ~/.profile

# Install Vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install Vundle Plugins
vim +PluginInstall +qall

# Install Homebrew
ruby -e "$(curl -fsSL
https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Cmake
brew install cmake

# Compile YouCompleteMe
~/.vim/bundle/YouCompleteMe/install.sh

# Install tmux
brew install tmux

# Install nodejs
brew install node
brew install watchman
brew install flow

# Install Bower and grunt
sudo npm install -g bower grunt-cli

# Install compass
sudo gem update --system
sudo gem install compass

# Install MongoDB
brew install mongodb

# Setup tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Setup copying and pasting to OS X clipboard from tmux
brew install reattach-to-user-namespace

