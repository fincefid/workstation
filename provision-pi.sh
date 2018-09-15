#!/bin/sh

set -o errexit

echo "Starting "
#
# Execute commands as the superuser
#
sudo --validate

#
# Install brew
#
which -a git 
if [ $? != 0 ] ; then
  echo "Git not installed, installing now..."
fi

echo "Pi updating"
sudo apt-get update

sudo apt-get install nginx
sudo etc/init.d/nginx start

