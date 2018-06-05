#!/bin/bash

unzip ~/Dev/spaceman/src/rbenv-master.zip -d ~
mv ~/rbenv-master ~/.rbenv
mkdir ~/.rbenv/versions
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
 
mkdir ~/.rbenv/plugins
unzip ~/Dev/spaceman/src/ruby-build-master.zip -d ~/.rbenv/plugins
mv ~/.rbenv/plugins/ruby-build-master ~/.rbenv/plugins/ruby-build

PATH=$HOME/.rbenv/bin:$PATH      
eval "$(rbenv init -)"

~/Dev/spaceman/src/rbenv-doctor.sh
   
rm -rf ~/tmp
mkdir ~/tmp
cd ~/tmp
tar zxf ~/Dev/spaceman/src/ruby-2.5.1.tar.gz
cd ruby-2.5.1
./configure --prefix=$HOME/.rbenv/versions/2.5.1
make
make install
~/.rbenv/versions/2.5.1/bin/gem install --local ~/Dev/spaceman/src/bundler-1.16.2.gem
cd ~
rm -rf ~/tmp

rbenv global 2.5.1

eval "$(rbenv init -)"

ruby --version
