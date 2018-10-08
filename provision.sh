#!/usr/bin/env bash

set -o errexit
set -o pipefail

user=$(id -un)

install_brew_packages()
{
    echo "Brew updating"
    brew update
    brew bundle --file=modules/Brewfile
    brew doctor
    echo "Brew update completed"
}

#
# Install brew
#
which -s brew
if [[ $? == 1 ]] ; then
	echo "Homebrew not installed, installing now..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew install caskroom/cask/brew-cask
	install_brew_packages
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    install_brew_packages
fi

echo "finished"