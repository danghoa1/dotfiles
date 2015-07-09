ln -s dotfiles/.dir_colors ~/
ln -s dotfiles/.gitconfig ~/
ln -s dotfiles/.inputrc ~/
ln -s dotfiles/.Rprofile ~/
ln -s dotfiles/.solarized ~/
ln -s dotfiles/.tmux.conf ~/
ln -s dotfiles/.vim ~/
ln -s dotfiles/.vimrc ~/
ln -s dotfiles/.bashrc ~/

# Install Tools
sudo apt-get install build-essential cmake
sudo apt-get install python-dev

# Install Vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install Vundle Plugins
vim +PluginInstall +qall

# Compile YouCompleteMe
~/.vim/bundle/YouCompleteMe/install.sh

# Install tmux
sudo add-apt-repository ppa:pi-rho/dev
sudo apt-get update
sudo apt-get install tmux

# Install nodejs
sudo apt-get install node watchman flow

# Install Bower and grunt
sudo npm install -g bower grunt-cli

# Install compass
sudo apt-get install ruby
sudo apt-get install ruby-dev
sudo gem install compass

# Install MongoDB
sudo apt-get install mongodb

# Setup tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
