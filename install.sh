#!/bin/zsh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run Mac OS X custom configuration
echo "Running Mac OS X custom configuration..."
sh $DIR/osx.sh

# Link files
declare -a files=("bin" ".vim" ".vimrc" ".custom" ".gitconfig" ".gitignore" ".inputrc" ".gvimrc")
echo "\nLinking files..."
for file in "${files[@]}"; do
    echo " Linking $file to ~"
    rm -rf ~/$file
    ln -s $DIR/$file ~/$file
done

# zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm -rf ~/.zshrc 
ln -s $DIR/.zshrc ~/.zshrc

# brew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Casks
brew cask install java
brew cask install android-file-transfer
brew cask install jetbrains-toolbox
brew cask install dropbox
brew cask install alfred
brew cask install 1password
brew cask install iterm2
brew cask install moom
brew cask install rocket-chat
brew cask install sourcetree
brew cask install transmission
brew cask install google-chrome
brew cask install diffmerge
brew cask install the-unarchiver
brew cask install vlc
brew cask install spotify
brew cask install macvim
brew cask install atom
brew cask install skype
brew cask install slack
brew cask install teamviewer
brew cask install reveal
brew cask install ngrok

# other stuff
brew install coreutils findutils zlib

binaries=(
    ansible
    apache-spark
    hadoop  
    maven
    gradle
    telnet

    carthage

    icdiff 
    pandoc 
    moreutils
    watch
    apachetop
    dnsmasq
    freetype
    glib
    grep
    imagemagick
    jpeg
    libmemcached
    libxml2
    mpfr

    deployer
    percona-server
    nginx
    php@7.3

    popt
    unixodbc
    cloog
    elasticsearch
    gearman
    gmp
    highlight
    imap-uw
    libevent
    libmpc
    libxslt
    mcrypt
    node
    readline
    wget
    autoconf
    cmake
    gettext
    go
    htop-osx
    libffi
    libpng
    libyaml
    memcached
    openssl
    phpunit
    pwgen
    redis
    automake
    composer
    fish
    graphviz
    httpie
    isl
    libgpg-error
    libtiff
    little-cms2
    mercurial
    ossp-uuid
    sbt
    xz
    boost
    freetds
    icu4c
    jbig2dec
    libksba
    libtool
    lua
    mhash
    pcre
    pkg-config
    rabbitmq
    rabbitmq-c
    ngrep
    tree
    the_silver_searcher
    switchaudio-osx
)

brew install ${binaries[@]}
brew cleanup

pecl install imagick redis xdebug amqp igbinary gearman apcu msgpack memcached igbinary

brew services start php
brew services start percona-server
brew services start gearman
brew services start redis
brew services start elasticsearch
brew services start rabbitmq
brew services start memcached
brew services start nginx

# dnsmasq .bar
mkdir -pv $(brew --prefix)/etc/
echo 'address=/.bar/127.0.0.1' > $(brew --prefix)/etc/dnsmasq.conf
sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons
sudo mkdir -v /etc/resolver
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/bar'
sudo brew services start dnsmasq

# npm
npm install -g diff-so-fancy

# RVM, gems
\curl -sSL https://get.rvm.io | bash -s stable --ruby
gem install cocoapods
gem install fastlane
gem install capifony capistrano_rsync_with_remote_cache
gem install synx

# Fonts
git clone https://github.com/powerline/fonts.git && cd fonts && ./install.sh
