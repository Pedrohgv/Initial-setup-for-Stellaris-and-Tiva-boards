#!/bin/bash


#### This file sets up the system for coding CMSIS based firmware, and flashing it on the Stellaris/Tiva C Series Board#######

###### Extracted from http://www.jann.cc/2012/12/11/getting_started_with_the_ti_stellaris_launchpad_on_linux.html
# http://gnuarmeclipse.github.io/toolchain/install/
# https://github.com/scompo/stellaris-launchpad-template-gcc

###### Run this code on the desired installation folder with:

#============================== sudo ./initial_setup.sh===========================================

### Download the StellarisWare (or Tivaware) software from: http://www.ti.com/tool/sw-ek-lm4f120xl

### Download the latest package arm-none-eabi to $HOME:Microcontrollers

### Download the latest CMSIS pack version

#!/bin/bash

 sudo tar xjf $HOME/Microcontrollers/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2 -C /usr/local #extracts and installs 
# the arm toolchain in /usr/local (remember to change the name to the downloaded version)

echo "export PATH=$PATH:/usr/local/gcc-arm-none-eabi-5_4-2016q3/bin" >> $HOME/.bashrc #includes the folder
#with the compiler in the list of folders to be searched for executables


export PATH=$PATH:/usr/local/gcc-arm-none-eabi-5_4-2016q3/bin

sudo apt-get -y install lib32ncurses5	#installs some software

apt-get install git 	

apt-get install libtool 

apt-get install autoconf

apt-get install automake

apt-get install libusb-1.0-0-dev

apt-get install openocd

git clone https://github.com/utzig/lm4tools.git

cd lm4tools/lm4flash/

make

cp lm4flash /usr/bin/

git clone git://git.code.sf.net/p/openocd/code openocd.git

cd openocd.git

./bootstrap

./configure --prefix=/usr --enable-maintainer-mode --enable-stlink --enable-ti-icdi

make

make install

mkdir $HOME/Microcontrollers/Stellaris

mkdir $HOME/Microcontrollers/Stellaris/StellarisWare ##creates Stellaris folder

sudo cp /usr/share/openocd/scripts/board/ek-lm4f120xl.cfg $HOME/Microcontrollers/Stellaris

sudo cp $HOME/Microcontrollers/CMSIS/Include/* /usr/local/gcc-arm-none-eabi-5_4-2016q3/arm-none-eabi/include #copy some CMSIS files to the compiler folder

cd $HOME/Microcontrollers/Stellaris/StellarisWare

unzip $HOME/Microcontrollers/SW-EK-LM4F120XL-9453.exe	#unpack the .exe file


make

echo "ATTR{idVendor}=="15ba", ATTR{idProduct}=="0004", GROUP="plugdev", MODE="0660" # Olimex Ltd. OpenOCD JTAG TINY
ATTR{idVendor}=="067b", ATTR{idProduct}=="2303", GROUP="plugdev", MODE="0660" # Prolific Technology, Inc. PL2303 Serial Port
ATTR{idVendor}=="10c4", ATTR{idProduct}=="ea60", GROUP="plugdev", MODE="0660" # USB Serial
ATTR{idVendor}=="1cbe", ATTR{idProduct}=="00fd", GROUP="plugdev", MODE="0660" # TI Stellaris Launchpad" >> /etc/udev/rules.d/10-local.rules

udevadm control --reload-rules


