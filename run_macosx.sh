ln -s dotfiles/.dir_colors ~/
ln -s dotfiles/.gitconfig ~/
ln -s dotfiles/.inputrc ~/
ln -s dotfiles/.Rprofile ~/
ln -s dotfiles/.solarized ~/
ln -s dotfiles/.tmux.conf ~/

# Mac OS uses .profile instead of .bashrc
ln -s dotfiles/.bashrc ~/.profile

# Install tmux
brew install tmux

# Install compass
sudo gem update --system
sudo gem install compass
