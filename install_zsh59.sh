#!/bin/sh -e
set -x #echo on
yum install -y ncurses-devel; yum clean all -y
sed -i -e 's/Defaults    requiretty.*/ #Defaults    requiretty/g' /etc/sudoers
cd ~
wget -O zsh-5.9.tar.xz -nv --no-check-certificate --content-disposition https://sourceforge.net/projects/zsh/files/zsh/5.9/zsh-5.9.tar.xz/download
tar xvf zsh-5.9.tar.xz
cd zsh-5.9
./configure --with-tcsetpgrp
make -j$(nproc)
sudo make install
echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
yum install -y util-linux-user; yum clean all -y
chsh -s /usr/local/bin/zsh
cd ~
rm -rf zsh-*
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
