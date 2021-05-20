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
brew install yarn
brew install maven

brew install --cask adoptopenjdk8 --require-sha
brew install --cask intellij-idea --appdir "$HOME/Applications" --require-sha

brew services start redis
brew services start mariadb@10.3

# setup mariadb

mariadb_path="/usr/local/opt/mariadb@10.3/bin/mysql"

if ! [ "$(which mysql)" == $mariadb_path ]; then
  if [ -f ~/.bash_profile ]; then
    echo "export PATH=\"$mariadb_path:$PATH\"" >> ~/.bash_profile
  fi

  if [ -f ~/.zshrc ]; then
    echo "export PATH=\"$mariadb_path:$PATH\"" >> ~/.zshrc
  fi

  if [ -f ~/.config/fish/config.fish ]; then
    echo "fish_add_path $mariadb_path" >> ~/.config/fish/config.fish
  fi
fi

# setup mariadb: create user and dbs

mysql -u root -Bse "CREATE USER 'jes'@'localhost' IDENTIFIED BY 'p@ssw0rd';
GRANT ALL PRIVILEGES ON *.* TO 'jes'@'localhost';
FLUSH PRIVILEGES;
CREATE DATABASE jes_test;
CREATE DATABASE jes_development;"

# setup mariadb: set my.cnf, use UTF8 encoding and tune for performance

curl https://raw.githubusercontent.com/scarvill91/edovo-onboarding/main/my.cnf -o /usr/local/etc/my.cnf

# install nvm & nodejs

if ! [ -x "$(command -v nvm)" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
  nvm install 8
  nvm use 8
  nvm alias default 8
else
  echo "Already installed: NVM"
fi

# install elasticsearch v7.8.0

if ! [ -d elasticsearch-7.8.0 ]; then
  curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.8.0-darwin-x86_64.tar.gz
  tar xf elasticsearch-7.8.0-darwin-x86_64.tar.gz
else
  echo "Already installed: elasticsearch v7.8.0"
fi

# setup JES: clone repo

git clone git@github.com:JailEducationSolutions/JES.git

# setup JES: create local application storage

sudo sh -c 'mkdir -p /opt/jes/media; chmod -R 0777 /opt/jes'

# setup JES: install frontend dependencies

yarn add global less@2.7.0
# yarn add global grunt grunt-cli jest@25

yarn --cwd jes/admin/src/main/javascript install
yarn --cwd jes/connect/src/main/javascript install
yarn --cwd jes/corrections2/src/main/javascript install
yarn --cwd jes/courses/src/main/javascript install
