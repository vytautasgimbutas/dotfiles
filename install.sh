#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sh $DIR/osx

rm -rf ~/.vim
rm -rf ~/.vimrc 
rm -rf ~/.zshrc 
rm r-f ~/.bashrc
rm -rf ~/.gitconfig 
rm -rf ~/.hgrc

ln -s "$DIR/.vim" ~/.vim
ln -s "$DIR/.vimrc" ~/.vimrc
ln -s "$DIR/.zshrc" ~/.zshrc
ln -s "$DIR/.bashrc" ~/.bashrc
ln -s "$DIR/.gitconfig" ~/.gitconfig
ln -s "$DIR/.hgrc" ~/.hgrc
