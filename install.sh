#!/bin/bash

# install xcode tools

xcode-select --install

# install homebrew

if ! [ -x "$(command -v brew)" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Already installed: Homebrew"
fi

# homebrew installs

brew tap adoptopenjdk/openjdk

brew install redis
brew install mariadb@10.3
brew install imagemagick

brew install --cask adoptopenjdk8 --require-sha
brew install --cask intellij-idea --appdir "$HOME/Applications" --require-sha

# setup mariadb

brew services start mariadb@10.3

mariadb_path="/usr/local/opt/mariadb@10.3/bin/mysql"

if ! [ "$(which mysql)" == $mariadb_path ]; then
  if [ -f ~/.bash_profile ]; then
    echo "export PATH=\"$mariadb_path:$PATH\"" >> ~/.bash_profile
  fi

  if [ -f ~/.bash_profile ]; then
    echo "fish_add_path $mariadb_path" >> ~/.config/fish/config.fish
  fi
fi

# install nvm & node v8

# if ! [ -x "$(command -v nvm)" ]; then
#   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
#   nvm install 8
#   nvm use 8
#   nvm alias default 8
# else
#   echo "Already installed: NVM"
# fi

# install elasticsearch v7.8.0

if ! [ -d elasticsearch-7.8.0 ]; then
  curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.8.0-darwin-x86_64.tar.gz
  tar xf elasticsearch-7.8.0-darwin-x86_64.tar.gz
else
  echo "Already installed: elasticsearch v7.8.0"
fi
