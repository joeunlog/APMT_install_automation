#!/bin/bash

######################### directory setting ########################
echo -e "\e[1;34m=======================================================\e[0m"
echo -e "\e[1;34m[ Start installing apache ]\e[0m"
echo -e "\e[1;44m[ If you want 'default' option, press 'enter' ]\e[0m"
echo -e "\e[1;34m[ For apache, It will create directory named 'apache' ]\e[0m"

# input - apache install 'parent' directory
# Apache will be installed at '/path/to/parent/directory/apache'
echo -ne "\e[1;44m>>> Enter parent directory for install (default : /usr/local) : \e[0m"
read apadir

if [ -z $apadir ]
then
    apadir=/usr/local
fi

# check input directory is valid
# if not valid, ask again until user input correctly
while [ ! -d $apadir ] || [ -z $apadir ]
do
    if [ -z $apadir ]
    then
        apadir=/usr/local
    else
        echo -e "\e[1;34m$apadir is not a directory, try again\e[0m"
        echo -e "\e[1;34m-----------------------------------------------\e[0m"
        echo -ne "\e[1;44m>>> Enter parent directory for install (default : /usr/local) : \e[0m"
        read apadir
    fi
done

# Create apache directory
cd $apadir
mkdir ./apache

# $apadir/apache
cd ./apache

# print apache directory
echo -e "\e[1;34m[ Apache will be installed at '$(pwd)' ]\e[0m"

# Create setupfiles download directory - It will be removed at final
cd ..
mkdir apachesetupfiles

# $apadir/apachesetupfiles
cd ./apachesetupfiles

########################### wget ##################################
# Check there is 'wget'
# if not, install wget by yum
if [ -z "$(yum list installed | grep wget)" ]
then
    echo -e "\e[1;34m=======================================================\e[0m"
    echo -e "\e[1;34m[ There is no wget, now install ]\e[0m"
    yum -y install wget
fi

#################### download apache setup file ####################
# input - apache version
echo -e "\e[1;34m=======================================================\e[0m"
echo -ne "\e[1;44m>>> Enter apache version (default : 2.4.46) : \e[0m"
read apaver

if [ -z $apaver ]
then
    apaver=2.4.46
fi

# Try download apache setup file
wget -P . http://archive.apache.org/dist/httpd/httpd-${apaver}.tar.gz

# if there is error, ask again until user input correctly
while [ $? -ne 0 ]
do
    if [ -z $apaver ]
    then
        apaver=2.4.46
    else
        echo -e "\e[1;34mThere is not exist version in archive\e[0m"
        echo -e "\e[1;34mCheck follow url and try again\e[0m"
        echo -e "\e[1;34mhttp://archive.apache.org/dist/httpd/?C=M;O=D\e[0m"
        echo -e "\e[1;34m-----------------------------------------------\e[0m"
        echo -ne "\e[1;44m>>> Enter apache version (default : 2.4.46) : \e[0m"
        read apaver
    fi
    wget -P . http://archive.apache.org/dist/httpd/httpd-${apaver}.tar.gz
done

apaver=$(ls | grep httpd)
tar xfz $apaver

# set variable to untar directory name
apaver=$(ls | grep httpd.*[^z]$)

#################### download apr setup file ####################
# input - apr version
echo -e "\e[1;34m=======================================================\e[0m"
echo -ne "\e[1;44m>>> Enter apr version (default : 1.6.5) : \e[0m"
read aprver

if [ -z $aprver ]
then
    aprver=1.6.5
fi

# Try download apr setup file
wget -P . https://archive.apache.org/dist/apr/apr-${aprver}.tar.gz

# if there is error, ask again until user input correctly
while [ $? -ne 0 ]
do
    if [ -z $aprver ]
    then
        aprver=1.6.5
    else
        echo -e "\e[1;34mThere is not exist version in archive\e[0m"
        echo -e "\e[1;34mCheck follow url and try again\e[0m"
        echo -e "\e[1;34mhttps://archive.apache.org/dist/apr/\e[0m"
        echo -e "\e[1;34m-----------------------------------------------\e[0m"
        echo -ne "\e[1;44m>>> Enter apr version (default : 1.6.5) : \e[0m"
        read aprver
    fi
    wget -P . https://archive.apache.org/dist/apr/apr-${aprver}.tar.gz
done

aprver=$(ls | grep apr-[0-9])
tar xfz $aprver

# set variable to untar directory name
aprver=$(ls | grep apr-[0-9].*[^z]$)

#################### download apr-util setup file ####################
# input - apr-util version
echo -e "\e[1;34m=======================================================\e[0m"
echo -ne "\e[1;44m>>> Enter apr-util version (default : 1.6.1) : \e[0m"
read aprutilver

if [ -z $aprutilver ]
then
    aprutilver=1.6.1
fi

# Try download apr-util setup file
wget -P . https://archive.apache.org/dist/apr/apr-util-${aprutilver}.tar.gz

# if there is error, ask again until user input correctly
while [ $? -ne 0 ]
do
    if [ -z $aprutilver ]
    then
        aprutilver=1.6.1
    else
        echo -e "\e[1;34mThere is not exist version in archive\e[0m"
        echo -e "\e[1;34mCheck follow url and try again\e[0m"
        echo -e "\e[1;34mhttps://archive.apache.org/dist/apr/\e[0m"
        echo -e "\e[1;34m-----------------------------------------------\e[0m"
        echo -ne "\e[1;44m>>> Enter apr-util version (default : 1.6.1) : \e[0m"
        read aprutilver
    fi
    wget -P . https://archive.apache.org/dist/apr/apr-util-${aprutilver}.tar.gz
done

aprutilver=$(ls | grep apr-util)
tar xfz $aprutilver

# set variable to untar directory name
aprutilver=$(ls | grep apr-util.*[^z]$)

#################### download pcre setup file ####################
# input - pcre version
echo -e "\e[1;34m=======================================================\e[0m"
echo -ne "\e[1;44m>>> Enter pcre version (default : 8.44) : \e[0m"
read pcrever

if [ -z $pcrever ]
then
    pcrever=8.44
fi

# Try download pcre setup file
wget -P . https://ftp.pcre.org/pub/pcre/pcre-${pcrever}.tar.gz --no-check-certificate

# if there is error, ask again until user input correctly
while [ $? -ne 0 ]
do
    if [ -z $pcrever ]
    then
        pcrever=8.44
    else
        echo -e "\e[1;34mThere is not exist version in archive\e[0m"
        echo -e "\e[1;34mCheck follow url and try again\e[0m"
        echo -e "\e[1;34mhttps://ftp.pcre.org/pub/pcre/\e[0m"
        echo -e "\e[1;34m-----------------------------------------------\e[0m"
        echo -ne "\e[1;44m>>> Enter pcre version (default : 8.44) : \e[0m"
        read pcrever
    fi
    wget -P . https://ftp.pcre.org/pub/pcre/pcre-${pcrever}.tar.gz --no-check-certificate
done

pcrever=$(ls | grep pcre)
tar xfz $pcrever

# set variable to untar directory name
pcrever=$(ls | grep pcre.*[^z]$)

######################## gcc, gcc-c++ ##########################
# check gcc installed
# if not, install gcc
yum list installed | grep ^gcc.x86_64
if [ $? -ne 0 ]
then
    echo -e "\e[1;34m=======================================================\e[0m"
    echo -e "\e[1;44m[ There is no gcc, now install ]\e[0m"
    yum install -y gcc
fi

# check gcc-c++ installed
# if not, install gcc-c++
yum list installed | grep ^gcc-c++.x86_64
if [ $? -ne 0 ]
then
    echo -e "\e[1;34m=======================================================\e[0m"
    echo -e "\e[1;44m[ There is no gcc-c++, now install ]\e[0m"
    yum install -y gcc-c++
fi

######################### pcre compile ############################
# $apadir/apachesetupfiles/$pcrever
cd $pcrever

# pcre configure
./configure --prefix=$apadir

# configure check
if [ $? -ne 0 ]
then
    echo -e "\e[1;31mpcre configure fail : Check script\e[0m"
    exit 0
fi

# pcre make && make install
make && make install

# make install check
if [ $? -ne 0 ]
then
    echo -e "\e[1;31mpcre make && make install fail : Check script\e[0m"
    exit 0
fi

###################### mv apr, apr-util #########################
# $apadir/apachesetupfiles/
cd ..

mv ./$aprver ./$apaver/srclib/apr
mv ./$aprutilver ./$apaver/srclib/apr-util

############ expat for apache compile - yum install ##############
if [ -z "$(yum list installed | grep expat-devel)" ]
then
    echo -e "\e[1;34m=======================================================\e[0m"
    echo -e "\e[1;44m[ There is no expat-devel, now install ]\e[0m"
    yum -y install expat-devel
fi

##################### apache compile #############################
# $apadir/apachesetupfiles/$apaver
cd $apaver

# apache configure
./configure --prefix=$apadir/apache --with-included-apr --with-pcre=$apadir/bin/pcre-config

# configure check
if [ $? -ne 0 ]
then
    echo -e "\e[1;31mapache configure fail : Check script\e[0m"
    exit 0
fi

# apache make && make install
make && make install

# make install check
if [ $? -ne 0 ]
then
    echo -e "\e[1;31mapache make && make install fail : Check script\e[0m"
    exit 0
fi

################### edit httpd.conf - ServerName #################
sed -i "/ServerName www/a ServerName localhost:80" $apadir/apache/conf/httpd.conf

echo -e "\e[1;34m=======================================================\e[0m"
echo -e "\e[1;46mServerName is 'localhost:80'\e[0m"
echo -e "\e[1;46mIf you want to change, edit '$apadir/apache/conf/httpd.conf'\e[0m"

################### finish or register service ######################
echo -e "\e[1;34m=======================================================\e[0m"
echo -ne "\e[1;46mRegister service ? [y/n] (default : y)\e[0m"
read fire

while [ $fire != 'y' ] && [ -n $fire ] && [ $fire != 'n' ]
do
    echo -e "\e[1;34m-----------------------------------------------\e[0m"
    echo -e "\e[1;34mPlease check enter condition\e[0m"
    echo -ne "\e[1;46mRegister service ? [y/n] (default : y)\e[0m"
    read fire
done

if [ $fire = 'n' ]
then
    ######### finish ##########
    echo -e "\e[1;34m=======================================================\e[0m"
    echo -e "\e[1;46mApache install process is done !\e[0m"
    echo -e "\e[1;46mRun Apache by '$apadir/apache/bin/apachectl start' command !\e[0m"
else
    ######### Register service #########
    registerpath=/usr/lib/systemd/system/httpd.service
    touch $registerpath
    echo "[Unit]" >> $registerpath
    echo "Description=Apache Service" >> $registerpath
    echo "" >> $registerpath
    echo "[Service]" >> $registerpath
    echo "Type=forking" >> $registerpath
    echo "PIDFile=$apadir/apache/logs/httpd.pid" >> $registerpath
    echo "ExecStart=$apadir/apache/bin/apachectl start" >> $registerpath
    echo "ExecReload=$apadir/apache/bin/apachectl graceful" >> $registerpath
    echo "ExecStop=$apadir/apache/bin/apachectl stop" >> $registerpath
    echo "KillSignal=SIGCONT" >> $registerpath
    echo "PrivateTmp=true" >> $registerpath
    echo "" >> $registerpath
    echo "[Install]" >> $registerpath
    echo "WantedBy=multi-user.target" >> $registerpath
    echo -e "\e[1;34m=======================================================\e[0m"
    echo -e "\e[1;46mApache install and register service process is done !\e[0m"
    echo -e "\e[1;46mRun Apache by 'systemctl start httpd' command !\e[0m"
fi