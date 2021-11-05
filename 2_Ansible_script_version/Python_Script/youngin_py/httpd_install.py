#!/usr/bin/env python
import os

# input version
apache_version = raw_input("enter apache version : ")
apr_version = raw_input("enter apr version: ")
apr_util_version = raw_input("enter apr_util version : ")
pcre_version = raw_input("enter pcre version : ")

# install dependency package
print("-----------------------------install dependency package-----------------------------")
os.system('yum -y install gcc gcc-c++ expat-devel wget')

# move path
os.chdir('/usr/local/src')

# download apache
print("-----------------------------download apache-----------------------------")
url_apache_download = "wget http://archive.apache.org/dist/httpd/httpd-{}.tar.gz".format(apache_version)
os.system(url_apache_download)

# extract apache
print("-----------------------------extract apache-----------------------------")
extract_apache = "tar xzvf httpd-{}.tar.gz".format(apache_version)
os.system(extract_apache)

# download apr
print("-----------------------------download apr-----------------------------")
url_apr_download = "wget https://archive.apache.org/dist/apr/apr-{}.tar.gz".format(apr_version)
os.system(url_apr_download)

# extract apr
print("-----------------------------extract apr-----------------------------")
extract_apr = "tar xzvf apr-{}.tar.gz".format(apr_version)
os.system(extract_apr)

# download apr-util
print("-----------------------------download apr-util-----------------------------")
url_apr_util_download = "wget https://archive.apache.org/dist/apr/apr-util-{}.tar.gz".format(apr_util_version)
os.system(url_apr_util_download)

# extract apr-util
print("-----------------------------extract apr-util-----------------------------")
extract_apr_util = "tar xzvf apr-util-{}.tar.gz".format(apr_util_version)
os.system(extract_apr_util)

# download pcre
print("-----------------------------download pcre-----------------------------")
url_pcre_download = "wget https://sourceforge.net/projects/pcre/files/pcre/{}/pcre-{}.tar.gz/download --no-check-certificate".format(pcre_version, pcre_version)
os.system(url_pcre_download)

# extract pcre
print("-----------------------------extract pcre-----------------------------")
extract_pcre = "tar xzvf download"
os.system(extract_pcre)

# configure pcre
print("-----------------------------configure pcre-----------------------------")
pcre_dir_path = "/usr/local/src/pcre-{}".format(pcre_version)
os.chdir(pcre_dir_path)
os.system("./configure --prefix=/usr/local/src")

# start pcre make && make install
print("-----------------------------start pcre make && make install-----------------------------")
os.system("make && make install")

# move apr & apr-util to inside of apache
os.system("mv /usr/local/src/apr-1.6.5 /usr/local/src/httpd-2.4.46/srclib/apr")
os.system("mv /usr/local/src/apr-util-1.6.1 /usr/local/src/httpd-2.4.46/srclib/apr-util")

# configure apache
print("-----------------------------configure apache-----------------------------")
apache_dir_path = "usr/local/src/httpd-{}".format(apache_version)
os.chdir(apache_dir_path)
os.system("./configure --prefix=/usr/local/src/apache --with-included-apr --with-pcre=/usr/local/src/bin/pcre-config")

# start apache make && make install
print("-----------------------------start apache make && make install-----------------------------")
os.system("make && make install")