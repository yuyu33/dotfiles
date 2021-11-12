# create directory
mkdir -p ~/.vim/rc 
# mkdir ~/.vim/rc
# mkdir ~/.vim/colors

# Install dein.vim
curl https//raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/installer.sh
sh ~/installer.sh ~/.cache

# Install flake8
pip3 install flake8 --user

# tmux
mkdir -p ~/.tmux/theme/
wget -O $HOME/.tmux/theme/iceberg_minimal.tmux.conf https://raw.githubusercontent.com/gkeep/iceberg-dark/master/.tmux/iceberg_minimal.tmux.conf

# Create a new Zsh configuration by copying the Zsh configuration files provided
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
