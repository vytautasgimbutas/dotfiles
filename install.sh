#!/bin/zsh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run Mac OS X custom configuration
echo "Running Mac OS X custom configuration..."
sh $DIR/osx.sh

# Link files
files="bin .vim .vimrc .custom .gitattributes .gitconfig .gitignore .hgignore .hgrc .inputrc .pythonrc"
echo "\nLinking files..."
for file in $files; do
    echo "  Linking $file to ~"
    rm -rf ~/$file
    ln -s $DIR/$file ~/$file
done

# zshrc
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

chsh -s /bin/zsh

rm -rf ~/.zshrc ~/.zpreztorc
ln -s $DIR/zprezto/zshrc ~/.zshrc
ln -s $DIR/zprezto/zpreztorc ~/.zpreztorc

# brew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

mkdir -p ~/Library/LaunchAgents

# Casks
brew cask install java
brew cask install dropbox
brew cask install alfred
brew cask install 1password
brew cask install genymotion
brew cask install iterm2
brew cask install moom
brew cask install rocket-chat
brew cask install sourcetree
brew cask install transmission
brew cask install google-chrome
brew cask install firefox
brew cask install diffmerge
brew cask install calibre
brew cask install the-unarchiver
brew cask install trim-enabler
brew cask install vlc
brew cask install jd-gui
brew cask install virtualbox
brew cask install spotify
brew cask install bettertouchtool
brew cask install sketch
brew cask install android-studio intellij-idea phpstorm appcode macvim
brew cask install atom
brew cask install colorsnapper
brew cask install deco
brew cask install docker
brew cask install skype

# other stuff
brew install coreutils findutils

brew tap homebrew/dupes
brew tap pivotal/tap

brew install php70 --with-pear
brew install --HEAD homebrew/php/php70-memcached
# not available as of this moment
    #php70-xhprof
    #php70-libevent
    #php70-mysqlnd_ms
    #php70-protobuf
    #php70-mcrypt
    #php70-thrift
    #php70-zookeeper
    #php70-crypto

binaries=(
    homebrew/dupes/grep
  
    springboot
    apache-spark
    hadoop  
    android-sdk
    android-ndk
    maven
    gradle

    carthage
    swiftlint

    macvim
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

    percona-server

    php70-amqp
    php70-imagick
    php70-igbinary
    php70-gearman
    php70-opcache
    php70-apcu
    php70-msgpack
    php70-pdo-pgsql
    php70-redis
    php70-intl
    php70-xdebug
    homebrew/php/boris

    popt
    unixodbc
    apple-gcc42
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
    findutils
    gettext
    go
    htop-osx
    irssi
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
    coreutils
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
    zlib

    ngrep

    nginx
    tree
)

brew install ${binaries[@]}
brew cleanup

brew linkapps macvim

brew services start memcached
brew services start homebrew/php/php70
brew services start percona-server
brew services start gearman
brew services start redis
brew services start elasticsearch
brew services start rabbitmq
brew services start memcached
brew services start php70
brew services start nginx

# dnsmasq .dev
mkdir -pv $(brew --prefix)/etc/
echo 'address=/.dev/127.0.0.1' > $(brew --prefix)/etc/dnsmasq.conf
sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons
sudo mkdir -v /etc/resolver
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/dev'
sudo brew services start dnsmasq

# npm
npm install -g diff-so-fancy

# RVM, gems
\curl -sSL https://get.rvm.io | bash -s stable --ruby
gem install cocoapods
gem install fastlane

# Fonts
git clone https://github.com/powerline/fonts.git && cd fonts && ./install.sh

#ssh-agent stuff
cp $DIR/ssh.add.a.plist ~/Library/LaunchAgents
launchctl load -w ~/Library/LaunchAgents/ssh.add.a.plist
