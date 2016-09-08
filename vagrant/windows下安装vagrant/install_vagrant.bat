%~d0
cd %~dp0
download.bat https://releases.hashicorp.com/vagrant/1.8.5/ vagrant_1.8.5.msi
msiexec /I ./vagrant_1.8.5.msi
vagrant box add precise32 http://files.vagrantup.com/precise32.box
vagrant init
vagrant up
vagrant ssh
pause