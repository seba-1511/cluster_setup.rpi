sudo apt-get update
sudo apt-get -y install ca-certificates

# Enable OpenSSH
read -p "You will now need to enable SSH manually. Press enter."
sudo raspi-config

# Allow all SSH connections
# sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
# sudo sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
# sudo sed -i 's/RSAAuthentication yes/RSAAuthentication no/g' /etc/ssh/sshd_config
# sudo sed -i 's/PubkeyAuthentication yes/PubkeyAuthentication no/g' /etc/ssh/sshd_config

# Install PSSH
sudo add-apt-repository ppa:thelupine/ppa # Not sure this line is useful
sudo apt-get update
sudo apt -y install pssh

# Install tmux
sudo apt-get -y install tmux
# END OpenSSH

# Python Install
sudo add-apt-repository ppa:fkrull/deadsnakes
sudo apt-get update
sudo apt-get -y install python2.7
# Install pip and the pip requirements
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
rm get-pip.py
# END Python

# Install VIM
sudo apt-get -y remove --purge vim vim-runtime vim-gnome vim-tiny vim-common vim-gui-common
sudo apt-get -y install liblua5.1-dev luajit libluajit-5.1 python-dev ruby-dev libperl-dev mercurial libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev

sudo mkdir /usr/include/lua5.1/include
sudo ln -s /usr/include/luajit-2.0 /usr/include/lua5.1/include

cd ~
git clone https://github.com/vim/vim.git
cd vim/src
make distclean
./configure --with-features=huge \
    --enable-rubyinterp \
    --enable-largefile \
    --disable-netbeans \
    --enable-pythoninterp \
    --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
    --enable-perlinterp \
    --enable-luainterp \
    --with-luajit \
    --enable-gui=auto \
    --enable-fail-if-missing \
    --with-lua-prefix=/usr/include/lua5.1 \
    --enable-cscope
make
sudo make install
cd ..
sudo mkdir /usr/share/vim
sudo mkdir /usr/share/vim/vim74
sudo cp -fr runtime/* /usr/share/vim/vim74/
curl -k https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein_installer.sh
sh ./dein_installer.sh ~/.vim
rm ./dein_installer.sh
# END VIM

# NVIM install
sudo apt-get -y install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get -y install neovim
sudo apt-get -y install python-dev python-pip python3-dev python3-pip

pip install neovim
pip3 install neovim

# Neovim symlinks creation
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
# END NVIM

# Install OpenMPI
sudo apt-get install -y openmpi
# END OpenMPI

# Install PyTorch

# END Pytorch

# Copy Seb's config
git clone https://github.com/seba-1511/config ~/config
cd ~/config && sudo sh ./install.sh

cd ~/config && pip install -r ./pip_reqs.txt 

# Misc Installs
sudo apt-get -y install htop
