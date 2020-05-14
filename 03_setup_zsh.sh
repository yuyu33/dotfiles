# Launch Zsh
zsh

# Clone the repository
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Create a new Zsh configuration by copying the Zsh configuration files provided
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Set Zsh as your default shell
chsh -s /usr/bin/zsh
