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

################### Initialize install log file ################
host=$(hostname)
echo "========================== Install php ==========================" > /tmp/${host}_phpinstall_log


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
    echo "=======================================================" >> /tmp/${host}_phpinstall_log
    echo "[ There is no wget, now install ]" >> /tmp/${host}_phpinstall_log
    yum -y install wget
fi

########################### package install ##################################

echo "=======================================================" >> /tmp/${host}_phpinstall_log
echo "[ Now install libxml2-devel, openssl-devel, libjpeg-devel, libpng-devel ]" >> /tmp/${host}_phpinstall_log
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
    echo "=======================================================" >> /tmp/${host}_phpinstall_log
    echo "php version is not vaild, check version or file download url" >> /tmp/${host}_phpinstall_log
    exit 0
fi

echo "=======================================================" >> /tmp/${host}_phpinstall_log
echo "php ${phpver} version download" >> /tmp/${host}_phpinstall_log

########################### tar php download file #########################
phpver=$(ls | grep php.*z$)
tar xfz $phpver

# set variable to untar directory name
phpver=$(ls | grep php.*[^zg]$)

############################ edit perl directory ########################

sed -i "s/bin\/perl -w/usr\/bin\/perl/g" $apadir/bin/apxs


############################# configure php ##########################
cd $phpver

apadir=$3

if [ -z $apadir ]
then
    apadir=/usr/local/src/apache
fi

./configure --prefix=$phpdir/php --with-apxs2=$apadir/bin/apxs --with-mysqli=mysqlnd --with-imap-ssl --with-iconv --with-openssl --with-mysql-sock=mysqlnd --enable-mysqlnd --disable-fileinfo

echo "=======================================================" >> /tmp/${host}_phpinstall_log
echo "Configure finished" >> /tmp/${host}_phpinstall_log
echo "Configure option : --prefix=$phpdir/php --with-apxs2=$apadir/bin/apxs --with-mysqli=mysqlnd" >> /tmp/${host}_phpinstall_log
echo "--with-imap-ssl --with-iconv --with-openssl --with-mysql-sock=mysqlnd --enable-mysqlnd --disable-fileinfo" >> /tmp/${host}_phpinstall_log

################################# make & make install ##################################
make

echo "=======================================================" >> /tmp/${host}_phpinstall_log
echo "Make finished" >> /tmp/${host}_phpinstall_log

make install

echo "=======================================================" >> /tmp/${host}_phpinstall_log
echo "Make install finished" >> /tmp/${host}_phpinstall_log

############################### finish #######################################
echo "=======================================================" >> /tmp/${host}_phpinstall_log
echo "If you want to activate php module, edit $apadir/conf/httpd.conf" >> /tmp/${host}_phpinstall_log
echo "Add 'AddType application/x-httpd-php .php .html' in mime_module" >> /tmp/${host}_phpinstall_log
echo "And restart apache using '$apadir/bin/apachectl stop', 'start'" >> /tmp/${host}_phpinstall_log