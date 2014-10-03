#!/bin/zsh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run Mac OS X custom configuration
echo "Running Mac OS X custom configuration..."
sh $DIR/osx.sh

# Link files
files="bin .zprezto .vim .vimrc .custom .gitattributes .gitconfig .gitignore .hgrc .inputrc .pythonrc .zshrc"
echo "\nLinking files..."
for file in $files; do
    echo "  Linking $file to ~"
    rm -rf ~/$file
    ln -s $DIR/$file ~/$file
done

# zprezto
for rcfile in "$$HOME"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "$$HOME/.${rcfile:t}"
done


# brew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install coreutils

brew install findutils

brew tap homebrew/dupes
brew install homebrew/dupes/grep

binaries=(
    apachetop
    boris
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
    popt
    rabbitmq-c
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
    php54
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
    wkhtmltopdf
    automake
    composer
    fish
    gfortran
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
    ghostscript
    grc
    icu4c
    jbig2dec
    libksba
    libtool
    lua
    mhash
    pcre
    php56-crypto
    php56-memcache
    php56-xdebug
    pkg-config
    rabbitmq
    tidy
    zlib
)

brew install ${binaries[@]}
brew cleanup