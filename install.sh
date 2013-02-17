#!/bin/zsh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run Mac OS X custom configuration
echo "Running Mac OS X custom configuration..."
sh $DIR/osx

# Link files
files="bin .zprezto .tmux.conf .vim .vimrc .custom .gitattributes .gitconfig .gitignore .hgrc .inputrc .pythonrc .zshrc"
echo "\nLinking files..."
for file in $files; do
    echo "  Linking $file to ~"
    rm -rf ~/$file
    ln -s $DIR/$file ~/$file
done

# zprezto
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
