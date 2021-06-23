#!/usr/bin/env bash

echo "Initialising..."

set -o errexit
set -o pipefail

#
# Execute commands as the superuser
#
sudo --validate

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

if [[ $? != 0 ]] ; then
	echo "Homebrew not installed, installing now..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	install_brew_packages
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Homebrew installed, installing packages"
    install_brew_packages
    omz update
fi

echo "finished"