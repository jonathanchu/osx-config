#!/usr/bin/env bash
#
# This installation is destructive, as it removes exisitng files/directories.
# Use at your own risk.
#
# Taken from https://github.com/mitchellh/dotfiles/blob/master/install.sh

for name in *; do
  if [ ! $name == "README.md" -a ! $name == "install.sh" ]; then
    target="$HOME/.$name"

    if [ -h $target ]; then
      rm $target
    elif [ -d $target ]; then
      rm -rf $target
    fi

    ln -s "$PWD/$name" "$target"
    echo "Linked $PWD/$name to $target."
  fi
done

# Bootstrap the environment
# Taken from https://github.com/jacobian/dotfiles/blob/master/bin/bootstrap.sh

echo "####### installing homebrew"
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

echo "####### installing git"
brew install git

echo "####### homebrewing the world"
bash ~/.brew

echo "####### python"
pip install -U pip
pip install -r ~/.requirements.txt

echo "####### fixing osx"
bash ~/.osx
