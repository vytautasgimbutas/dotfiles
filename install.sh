#!/bin/zsh

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# brew
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

/opt/homebrew/bin/brew install ansible

mkdir -p ~/Library/LaunchAgents
cp ssh-add.plist ~/Library/LaunchAgents/ssh-add.plist
sudo chown root:wheel ~/Library/LaunchAgents/ssh-add.plist
sudo launchctl load ~/Library/LaunchAgents/ssh-add.plist

# TODO: run playbook and move everything below to it

# RVM, gems
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source $HOME/.rvm/scripts/rvm
gem install cocoapods
gem install fastlane
gem install synx

# Fonts
git clone https://github.com/powerline/fonts.git && ./fonts/install.sh && rm -rf fonts
