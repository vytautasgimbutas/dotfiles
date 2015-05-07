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

rm ~/.zshrc ~/.zpreztorc
ln -s $DIR/zprezto/zshrc ~/.zshrc
ln -s $DIR/zprezto/zpreztorc ~/.zpreztorc

# brew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install coreutils findutils

brew tap homebrew/dupes
brew install homebrew/dupes/grep

binaries=(
    apachetop
    homebrew/php/boris
    dnsmasq
    freetype
    glib
    grep
    imagemagick
    jpeg
    libmemcached
    libxml2
    maven
    mpfr
    percona-server
    php56-gearman
    php56-memcached
    php56-xhprof
    php56-opcache
    php56-apcu
    php56-libevent
    php56-msgpack
    php56-mysqlnd_ms
    php56-protobuf
    popt
    unixodbc
    zookeeper
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
    php56-igbinary
    php56-pdo-pgsql
    php56-zookeeper
    postgresql
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
    php56
    php56-imagick
    php56-redis
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
    php56-amqp
    php56-mcrypt
    php56-thrift
    pidof
    qt
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
    php56-crypto
    php56-xdebug
    pkg-config
    rabbitmq
    zlib
    android-sdk
    android-ndk
    ngrep

    typesafe-activator
    nginx
)

brew install ${binaries[@]}
brew cleanup

# dnsmasq .dev
mkdir -pv $(brew --prefix)/etc/
echo 'address=/.dev/127.0.0.1' > $(brew --prefix)/etc/dnsmasq.conf
sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons
sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
sudo mkdir -v /etc/resolver
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/dev'

# memcached
ln -sfv /usr/local/opt/memcached/*.plist ~/Library/LaunchAgents            
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist

# percona-server
ln -sfv /usr/local/opt/percona-server/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.percona-server.plist

# rabbitmq
ln -sfv /usr/local/opt/rabbitmq/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.rabbitmq.plist

# elasticsearch
ln -sfv /usr/local/opt/elasticsearch/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist

# nginx
ln -sfv /usr/local/opt/nginx/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist

# php5-fpm
ln -sfv /usr/local/opt/php56/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.php56.plist

