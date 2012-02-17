#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sh $DIR/osx
rm -rf ~/.vim
rm -rf ~/.vimrc 
rm -rf ~/.zshrc 
rm -rf ~/.gitconfig 
rm -rf ~/.hgrc

ln -s "$DIR/.vim" ~/.vim
ln -s "$DIR/.vimrc" ~/.vimrc
ln -s "$DIR/.zshrc" ~/.zshrc
ln -s "$DIR/.gitconfig" ~/.gitconfig
ln -s "$DIR/.hgrc" ~/.hgrc
