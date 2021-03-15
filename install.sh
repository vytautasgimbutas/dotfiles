#!/bin/zsh

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# brew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install ansible

# TODO: run playbook and move everything below to it

# npm
npm install -g diff-so-fancy

# RVM, gems
\curl -sSL https://get.rvm.io | bash -s stable --ruby
export PATH="$PATH:$HOME/.rvm/bin"
gem install cocoapods
gem install fastlane
gem install synx

# Fonts
git clone https://github.com/powerline/fonts.git && cd fonts && ./install.sh && cd .. && rm -rf fonts
