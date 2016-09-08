#!/bin/sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
cd ~
brew tap phinze/cask
brew install brew-cask
brew cask install vagrant
brew cask install virtualbox
brew Install wget
mkdir linux
cd linux
wget http://files.vagrantup.com/precise32.box
cd ../
vagrant box add linux linux/precise32.box
vagrant init linux
vagrant up
vagrant ssh