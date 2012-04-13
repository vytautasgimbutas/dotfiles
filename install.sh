#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sh $DIR/osx

for file in {.vim,.vimrc,.custom,.gitattributes,.gitconfig,.gitignore,.hgrc,.inputrc,.pythonrc,.zshrc}; do
	rm -rf ~/$file && ln -s $DIR/$file ~/$file
done
unset file