#!/bin/bash

######################### variable check ###########################
# 1	mysqldir=/usr/local/src
# 2	mysqlver=5.7.31

# If there is no variable, set default
if [ $# = 0 ]
then
    mysqldir=""
    mysqlver=""
fi

######################### directory setting ########################
mysqldir=$1

if [ -z $mysqldir ]
then
    mysqldir=/usr/local/src
fi

mkdir -p $mysqldir

# Create mysql directory
cd $mysqldir
mkdir ./mysql

# $mysqldir/mysql
cd ./mysql

# print mysql directory
echo "[ mysql will be installed at '$(pwd)' ]" >> $mysqldir/mysqlinstall_log

# # Create setupfiles download directory - It will be removed at final
# $mysqldir
cd ..

########################### wget ##################################
# Check there is 'wget'
# if not, install wget by yum
if [ -z "$(yum list installed | grep wget)" ]
then
    echo "=======================================================" >> $mysqldir/mysqlinstall_log
    echo "[ There is no wget, now install ]" >> $mysqldir/mysqlinstall_log
    yum -y install wget
fi

########################### package install ##################################

echo "=======================================================" >> $mysqldir/mysqlinstall_log
echo "[ Now install cmake, make, gcc, gcc-c++, openssl, openssl-devel, ncurses, ncurses-base, ncurses-libs, ncurses-devel, perl ]" >> $mysqldir/mysqlinstall_log
yum -y install cmake make gcc gcc-c++ openssl openssl-devel ncurses ncurses-base ncurses-libs ncurses-devel perl

#################### download mysql setup file ####################
mysqlver=$2

if [ -z $mysqlver ]
then
    mysqlver=5.7.31
fi

# Try download mysql setup file
wget -P . https://cdn.mysql.com/archives/mysql-5.7/mysql-${mysqlver}.tar.gz

# if there is error, end process
if [ $? -ne 0 ]
then
    echo "=======================================================" >> $mysqldir/mysqlinstall_log
    echo "Mysql version is not vaild, check version or file download url" >> $mysqldir/mysqlinstall_log
    exit 0
fi

echo "Mysql ${mysqlver} version download" >> $mysqldir/mysqlinstall_log

mysqlver=$(ls | grep mysql.*z$)
tar xfz $mysqlver

# set variable to untar directory name
mysqlver=$(ls | grep mysql.*[^zg]$)

############################### cmake mysql #################################
cd $mysqlver

cmake -DCMAKE_INSTALL_PREFIX=$mysqldir/mysql -DMYSQL_DATADIR=$mysqldir/mysql/data -DMYSQL_UNIX_ADDR=$mysqldir/mysql/mysql.sock -DMYSQL_TCP_PORT=3306 -DMYSQL_USER=mysql -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DSYSCOMFDIR=/etc -DWITH_EXTRA_CHARSETS=all -DDOWNLOAD_BOOST=1 -DWITH_BOOST=$mysqldir/mysql/boost -DWITH_READLINE=1 -DENABLED_LOCAL_INFILE=1
echo "=======================================================" >> $mysqldir/mysqlinstall_log
echo "Cmake finished" >> $mysqldir/mysqlinstall_log
echo "Cmake option : -DCMAKE_INSTALL_PREFIX=$mysqldir/mysql -DMYSQL_DATADIR=$mysqldir/mysql/data" >> $mysqldir/mysqlinstall_log
echo "-DMYSQL_UNIX_ADDR=$mysqldir/mysql/mysql.sock -DMYSQL_TCP_PORT=3306 -DMYSQL_USER=mysql" >> $mysqldir/mysqlinstall_log
echo "-DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DSYSCOMFDIR=/etc -DWITH_EXTRA_CHARSETS=all" >> $mysqldir/mysqlinstall_log
echo "-DDOWNLOAD_BOOST=1 -DWITH_BOOST=$mysqldir/mysql/boost -DWITH_READLINE=1 -DENABLED_LOCAL_INFILE=1" >> $mysqldir/mysqlinstall_log

################################# make & make install ##################################
make

echo "=======================================================" >> $mysqldir/mysqlinstall_log
echo "Make finished" >> $mysqldir/mysqlinstall_log

make install

echo "=======================================================" >> $mysqldir/mysqlinstall_log
echo "Make install finished" >> $mysqldir/mysqlinstall_log
