#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run Mac OS X custom configuration
echo "Running Mac OS X custom configuration..."
sh $DIR/osx

# Link files
files="bin .zpreztorc .tmux.conf .vim .vimrc .custom .gitattributes .gitconfig .gitignore .hgrc .inputrc .pythonrc .zshrc"
echo "\nLinking files..."
for file in $files; do
    echo "  Linking $file to ~"
    rm -rf ~/$file
    ln -s $DIR/$file ~/$file
done

# nginx, php-fpm, php
echo "\nInstalling nginx, php-fpm, php configurations"
rm -rf /usr/local/etc/nginx/nginx.conf /usr/local/etc/php-fpm.conf /usr/local/etc/php/5.4/php.ini
ln -s $DIR/config/nginx/nginx.conf /usr/local/etc/nginx/
ln -s $DIR/config/php-fpm.conf /usr/local/etc/
ln -s $DIR/config/php.ini /usr/local/etc/php/5.4/
