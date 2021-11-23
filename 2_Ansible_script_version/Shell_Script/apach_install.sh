#!/bin/bash

######################### variable check ###########################
# 1	apadir=/usr/local/src
# 2	apaver=2.4.46
# 3	aprver=1.6.5
# 4	aprutilver=1.6.1
# 5	pcrever=8.44

if [ $# = 0 ]
then
    apadir=""
    apaver=""
    aprver=""
    aprutilver=""
    pcrever=""
fi

######################### directory setting ########################
apadir=$1

if [ -z $apadir ]
then
    apadir=/usr/local/src
fi

mkdir -p $apadir

# check input directory is valid
# if not valid, ask again until user input correctly
# if [ ! -d $apadir ]
# then
#     echo "Apache install directory is not valid" >> $apadir/apacheinstall_log
#     exit 0
# fi

# Create apache directory
cd $apadir
mkdir ./apache

# $apadir/apache
cd ./apache

# print apache directory
echo "[ Apache will be installed at '$(pwd)' ]" >> $apadir/apacheinstall_log

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
    echo "=======================================================" >> $apadir/apacheinstall_log
    echo "[ There is no wget, now install ]" >> $apadir/apacheinstall_log
    yum -y install wget
fi

#################### download apache setup file ####################
apaver=$2

if [ -z $apaver ]
then
    apaver=2.4.46
fi

# Try download apache setup file
wget -P . http://archive.apache.org/dist/httpd/httpd-${apaver}.tar.gz

# if there is error, ask again until user input correctly
if [ $? -ne 0 ]
then
    echo "Apache version is not vaild, check version or file download url" >> $apadir/apacheinstall_log
    exit 0
fi

echo "Apache ${apaver} version download" >> $apadir/apacheinstall_log

apaver=$(ls | grep httpd)
tar xfz $apaver

# set variable to untar directory name
apaver=$(ls | grep httpd.*[^z]$)

#################### download apr setup file ####################
aprver=$3

if [ -z $aprver ]
then
    aprver=1.6.5
fi

# Try download apr setup file
wget -P . https://archive.apache.org/dist/apr/apr-${aprver}.tar.gz

# if there is error, ask again until user input correctly
if [ $? -ne 0 ]
then
    echo "apr version is not valid, check version or file download url" >> $apadir/apacheinstall_log
    exit 0
fi

echo "Apr ${aprver} version download" >> $apadir/apacheinstall_log

aprver=$(ls | grep apr-[0-9])
tar xfz $aprver

# set variable to untar directory name
aprver=$(ls | grep apr-[0-9].*[^z]$)

#################### download apr-util setup file ####################
aprutilver=$4

if [ -z $aprutilver ]
then
    aprutilver=1.6.1
fi

# Try download apr-util setup file
wget -P . https://archive.apache.org/dist/apr/apr-util-${aprutilver}.tar.gz

# if there is error, ask again until user input correctly
if [ $? -ne 0 ]
then
    echo "apr-util version is not valid, check version of file download url" >> $apadir/apacheinstall_log
    exit 0
fi

echo "Apr-util ${aprutilver} version download" >> $apadir/apacheinstall_log

aprutilver=$(ls | grep apr-util)
tar xfz $aprutilver

# set variable to untar directory name
aprutilver=$(ls | grep apr-util.*[^z]$)

#################### download pcre setup file ####################
pcrever=$5

if [ -z $pcrever ]
then
    pcrever=8.44
fi

# Try download pcre setup file
wget -P . https://sourceforge.net/projects/pcre/files/pcre/${pcrever}/pcre-${pcrever}.tar.gz --no-check-certificate

# if there is error, ask again until user input correctly
if [ $? -ne 0 ]
then
    echo "pcre version is not valid, check version or file download url" < $apadir/apacheinstall_log
    exit 0
fi

echo "Pcre ${pcrever} version download" >> $apadir/apacheinstall_log

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
    echo "=======================================================" >> $apadir/apacheinstall_log
    echo "[ There is no gcc, now install ]" >> $apadir/apacheinstall_log
    yum install -y gcc
fi

# check gcc-c++ installed
# if not, install gcc-c++
yum list installed | grep ^gcc-c++.x86_64
if [ $? -ne 0 ]
then
    echo "=======================================================" >> $apadir/apacheinstall_log
    echo "[ There is no gcc-c++, now install ]" >> $apadir/apacheinstall_log
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
    echo "pcre configure fail : Check script" >> $apadir/apacheinstall_log
    exit 0
fi

# pcre make && make install
make && make install

# make install check
if [ $? -ne 0 ]
then
    echo "\pcre make && make install fail : Check script" >> $apadir/apacheinstall_log
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
    echo "=======================================================" >> $apadir/apacheinstall_log
    echo "[ There is no expat-devel, now install ]" >> $apadir/apacheinstall_log
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
    echo "apache configure fail : Check script" >> $apadir/apacheinstall_log
    exit 0
fi

# apache make && make install
make && make install

# make install check
if [ $? -ne 0 ]
then
    echo "apache make && make install fail : Check script" >> $apadir/apacheinstall_log
    exit 0
fi

################### edit httpd.conf - ServerName #################
sed -i "/ServerName www/a ServerName localhost:80" $apadir/apache/conf/httpd.conf

echo "=======================================================" >> $apadir/apacheinstall_log
echo "ServerName is 'localhost:80'" >> $apadir/apacheinstall_log
echo "If you want to change, edit '$apadir/apache/conf/httpd.conf'" >> $apadir/apacheinstall_log

################### finish ######################
echo "=======================================================" >> $apadir/apacheinstall_log
echo "Apache install process is done !" >> $apadir/apacheinstall_log
echo "Run Apache by '$apadir/apache/bin/apachectl start' command !" >> $apadir/apacheinstall_log
