#!/usr/bin/env bash

set -o errexit
set -o pipefail

user=$(id -un)

#
# Execute commands as the superuser
#
sudo --validate

#
# Install brew
#
which -s brew
if [[ $? != 0 ]] ; then
	echo "Homebrew not installed, installing now..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew install caskroom/cask/brew-cask
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

echo "Brew updating"
brew update
brew bundle --file=modules/Brewfile
brew doctor
echo "Brew update completed"

#
# Create symbolic links to Git config files
#
gitconfig="/Users/${user}/.gitconfig"
if [ -e "$gitconfig" ]
then
	echo "$gitconfig found. Not Creating"
else
    ln ./modules/git/.gitconfig ~/.gitconfig
    ln ./modules/git/.gitignore-global ~/.gitignore-global
fi


#
# Install Git pair program (TEAM WORKSTATION ONLY)
#
#gem install pivotal_git_scripts
#echo "Git pair installed"
#ln ./modules/git/.pairs ~/.pairs

#
# Start docker containers
#
#echo "Starting docker containers"
#if [[ $(docker ps -a -q) == 0 ]] ; then
#    docker kill $(docker ps -a -q)
#fi
#docker-compose -f modules/docker-compose.yml up &

#
# Set Zsh as default shell
#
#sudo echo "$(which zsh)" >> /etc/shells
chsh -s $(which zsh)
zsh -f
