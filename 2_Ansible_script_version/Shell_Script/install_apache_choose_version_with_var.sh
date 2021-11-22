#!/bin/bash

######################### variable check ###########################
# 1	apadir
# 2	apaver
# 3	aprver
# 4	aprutilver
# 5	pcrever

if [ $# = 0 ]
then
    $1 = ""
    $2 = ""
    $3 = ""
    $4 = ""
    $5 = ""
fi

######################### directory setting ########################
apadir = $1

if [ -z $apadir ]
then
    apadir=/usr/local
fi

# check input directory is valid
# if not valid, ask again until user input correctly
if [ ! -d $apadir ]
then
    echo "Apache install directory is not valid" > /tmp/apacheinstall
    exit 0
fi

# Create apache directory
cd $apadir
mkdir ./apache

# $apadir/apache
cd ./apache

# print apache directory
echo "[ Apache will be installed at '$(pwd)' ]" > /tmp/apacheinstall

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
    echo "=======================================================" > /tmp/apacheinstall
    echo "[ There is no wget, now install ]" > /tmp/apacheinstall
    yum -y install wget
fi

#################### download apache setup file ####################
apaver = $2

if [ -z $apaver ]
then
    apaver=2.4.46
fi

# Try download apache setup file
wget -P . http://archive.apache.org/dist/httpd/httpd-${apaver}.tar.gz

# if there is error, ask again until user input correctly
if [ $? -ne 0 ]
then
    echo "Apache version is not vaild, check version or file download url" > /tmp/apacheinstall
    exit 0
fi

apaver=$(ls | grep httpd)
tar xfz $apaver

# set variable to untar directory name
apaver=$(ls | grep httpd.*[^z]$)

#################### download apr setup file ####################
aprver = $3

if [ -z $aprver ]
then
    aprver=1.6.5
fi

# Try download apr setup file
wget -P . https://archive.apache.org/dist/apr/apr-${aprver}.tar.gz

# if there is error, ask again until user input correctly
if [ $? -ne 0 ]
then
    echo "apr version is not valid, check version or file download url" > /tmp/apacheinstall
    exit 0
fi

aprver=$(ls | grep apr-[0-9])
tar xfz $aprver

# set variable to untar directory name
aprver=$(ls | grep apr-[0-9].*[^z]$)

#################### download apr-util setup file ####################
aprutilver = $4

if [ -z $aprutilver ]
then
    aprutilver=1.6.1
fi

# Try download apr-util setup file
wget -P . https://archive.apache.org/dist/apr/apr-util-${aprutilver}.tar.gz

# if there is error, ask again until user input correctly
if [ $? -ne 0 ]
then
    echo "apr-util version is not valid, check version of file download url" > /tmp/apacheinstall
    exit 0
fi

aprutilver=$(ls | grep apr-util)
tar xfz $aprutilver

# set variable to untar directory name
aprutilver=$(ls | grep apr-util.*[^z]$)

#################### download pcre setup file ####################
pcrever = $5

if [ -z $pcrever ]
then
    pcrever=8.44
fi

# Try download pcre setup file
wget -P . https://ftp.pcre.org/pub/pcre/pcre-${pcrever}.tar.gz --no-check-certificate

# if there is error, ask again until user input correctly
if [ $? -ne 0 ]
then
    echo "pcre version is not valid, check version or file download url" < /tmp/apacheinstall
    exit 0
fi

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
    echo "=======================================================" > /tmp/apacheinstall
    echo "[ There is no gcc, now install ]" > /tmp/apacheinstall
    yum install -y gcc
fi

# check gcc-c++ installed
# if not, install gcc-c++
yum list installed | grep ^gcc-c++.x86_64
if [ $? -ne 0 ]
then
    echo "=======================================================" > /tmp/apacheinstall
    echo "[ There is no gcc-c++, now install ]" > /tmp/apacheinstall
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
    echo "pcre configure fail : Check script" > /tmp/apacheinstall
    exit 0
fi

# pcre make && make install
make && make install

# make install check
if [ $? -ne 0 ]
then
    echo "\pcre make && make install fail : Check script" > /tmp/apacheinstall
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
    echo "=======================================================" > /tmp/apacheinstall
    echo "[ There is no expat-devel, now install ]" > /tmp/apacheinstall
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
    echo "apache configure fail : Check script" > /tmp/apacheinstall
    exit 0
fi

# apache make && make install
make && make install

# make install check
if [ $? -ne 0 ]
then
    echo "apache make && make install fail : Check script" > /tmp/apacheinstall
    exit 0
fi

################### edit httpd.conf - ServerName #################
sed -i "/ServerName www/a ServerName localhost:80" $apadir/apache/conf/httpd.conf

echo "=======================================================" > /tmp/apacheinstall
echo "ServerName is 'localhost:80'" > /tmp/apacheinstall
echo "If you want to change, edit '$apadir/apache/conf/httpd.conf'" > /tmp/apacheinstall

################### finish ######################
echo "=======================================================" > /tmp/apacheinstall
echo "Apache install process is done !" > /tmp/apacheinstall
echo "Run Apache by '$apadir/apache/bin/apachectl start' command !" > /tmp/apacheinstall
