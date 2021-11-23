#!/bin/bash

######################### variable check ###########################
# 1 phpdir=/usr/local/src
# 2	phpver=7.3.32
# 3 apadir=/usr/local/src/apache

if [ $# = 0 ]
then
    phpdir=""
    phpver=""
    apadir=""
fi

######################### directory setting ########################
phpdir=$1

if [ -z $phpdir ]
then
    phpdir=/usr/local/src
fi

mkdir -p $phpdir

cd $phpdir

########################### wget ##################################
# Check there is 'wget'
# if not, install wget by yum
if [ -z "$(yum list installed | grep wget)" ]
then
    echo "=======================================================" >> $phpdir/phpinstall_log
    echo "[ There is no wget, now install ]" >> $phpdir/phpinstall_log
    yum -y install wget
fi

########################### package install ##################################

echo "=======================================================" >> $phpdir/phpinstall_log
echo "[ Now install libxml2-devel, openssl-devel, libjpeg-devel, libpng-devel ]" >> $phpdir/phpinstall_log
yum -y install libxml2-devel openssl-devel libjpeg-devel libpng-devel


#################### download php setup file ####################
phpver=$2

if [ -z $phpver ]
then
    phpver=7.3.32
fi

# Try download apache setup file
wget -P . https://www.php.net/distributions/php-${phpver}.tar.gz

# if there is error, ask again until user input correctly
if [ $? -ne 0 ]
then
    echo "php version is not vaild, check version or file download url" >> $phpdir/phpinstall_log
    exit 0
fi

echo "php ${phpver} version download" >> $phpdir/phpinstall_log

########################### tar php download file #########################
phpver=$(ls | grep php.*z$)
tar xfz $phpver

# set variable to untar directory name
phpver=$(ls | grep php.*[^zg]$)

############################# configure php ##########################
cd $phpver

apadir=$3

if [ -z $apadir ]
then
    apadir=/usr/local/src
fi

./configure --prefix=$phpdir/php --with-apxs=$apadir/bin/apxs --with-mysql --with-mysqli --with-zlib --with-jpeg --with-png --with-openssl --with-libxml --with-iconv --with-gd --enable-curl --enable-sockets --disable-fileinfo --disable-debug

echo "Configure finished" >> $phpdir/phpinstall_log
echo "Configure option : --prefix=$phpdir/php --with-apxs=$apadir/bin/apxs --with-mysql --with-mysqli" >> $phpdir/phpinstall_log
echo "--with-zlib --with-jpeg --with-png --with-openssl --with-libxml --with-iconv --with-gd --enable-curl" >> $phpdir/phpinstall_log
echo "--enable-sockets --disable-fileinfo --disable-debug" >> $phpdir/phpinstall_log

################################# make & make install ##################################
make

echo "Make finished" >> $phpdir/phpinstall_log

make install

echo "Make install finished" >> $phpdir/phpinstall_log