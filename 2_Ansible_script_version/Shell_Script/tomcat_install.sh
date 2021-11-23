#!/bin/bash

######################### variable check ###########################
# 1 tomcatdir=/usr/local/src
# 2	tomcatver=8.5.66

if [ $# = 0 ]
then
    tomcatdir=""
    tomcatver=""
fi

######################### directory setting ########################
tomcatdir=$1

if [ -z $tomcatdir ]
then
    tomcatdir=/usr/local/src
fi

mkdir -p $tomcatdir

cd $tomcatdir
########################### wget ##################################
# Check there is 'wget'
# if not, install wget by yum
if [ -z "$(yum list installed | grep wget)" ]
then
    echo "=======================================================" >> $tomcatdir/tomcatinstall_log
    echo "[ There is no wget, now install ]" >> $tomcatdir/tomcatinstall_log
    yum -y install wget
fi

########################### java-openjdk ##################################
# Check there is 'java-openjdk'
# if not, install java-openjdk by yum
if [ -z "$(yum list installed | grep java-1.8.0-openjdk)" ]
then
    echo "=======================================================" >> $tomcatdir/tomcatinstall_log
    echo "[ There is no java-1.8.0-openjdk, now install ]" >> $tomcatdir/tomcatinstall_log
    yum -y install java-1.8.0-openjdk
fi

#################### download tomcat setup file ####################
tomcatver=$2

if [ -z $tomcatver ]
then
    tomcatver=8.5.66
fi

# Try download apache setup file
wget -P . https://archive.apache.org/dist/tomcat/tomcat-8/v${tomcatver}/bin/apache-tomcat-${tomcatver}.tar.gz

# if there is error, ask again until user input correctly
if [ $? -ne 0 ]
then
    echo "Tomcat version is not vaild, check version or file download url" >> $tomcatdir/tomcatinstall_log
    exit 0
fi

echo "Tomcat ${tomcatver} version download" >> $tomcatdir/tomcatinstall_log

########################### tar tomcat download file #########################
tomcatver=$(ls | grep tomcat.*z$)
tar xfz $tomcatver

# set variable to untar directory name
tomcatver=$(ls | grep tomcat.*[^zg]$)

ln -s $tomcatver ./tomcat

################### finish ######################
echo "=======================================================" >> $tomcatdir/tomcatinstall_log
echo "Tomcat install process is done !" >> $tomcatdir/tomcatinstall_log
echo "Run Tomcat by '$tomcatdir/tomcat/bin/catalina.sh start' command !" >> $tomcatdir/tomcatinstall_log