#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run Mac OS X custom configuration
echo "Running Mac OS X custom configuration..."
sh $DIR/osx

# Link files
files="bin .zpreztorc .zprezto .tmux.conf .vim .vimrc .custom .gitattributes .gitconfig .gitignore .hgrc .inputrc .pythonrc .zshrc"
echo "\nLinking files..."
for file in $files; do
    echo "  Linking $file to ~"
    rm -rf ~/$file
    ln -s $DIR/$file ~/$file
done
