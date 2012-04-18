#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# run Mac OS X custom configuration
sh $DIR/osx

# link dotfiles
for file in {bin,.vim,.vimrc,.custom,.gitattributes,.gitconfig,.gitignore,.hgrc,.inputrc,.pythonrc,.zshrc}; do
	rm -rf ~/$file && ln -s $DIR/$file ~/$file
done
unset file


# nginx, php-fpm, php
rm /usr/local/etc/nginx/nginx.conf
ln -s $DIR/config/nginx/nginx.conf /usr/local/etc/nginx/
ln -s $DIR/config/nginx/vhosts /usr/local/etc/nginx/

rm /usr/local/etc/php-fpm.conf
ln -s $DIR/config/php-fpm.conf /usr/local/etc/

rm /usr/local/etc/php.ini
ln -s $DIR/config/php.ini /usr/local/etc/
