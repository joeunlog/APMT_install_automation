#!/usr/bin/env python

import subprocess
import sys

if 'https' or 'www' or 'tar.gz' in sys.argv[1]:
    user_url = sys.argv[1]
    mysql_dir = user_url[user_url.find('mysql-') : (user_url.find('.tar') -1)]
    mysql_file = user_url[user_url.find('mysql-') : ]
    subprocess.call('yum install -y cmake ncurses ncurses-devel ncurses-libs ncurses-static openssl openssl-devel bison readline gcc gcc-c++ make cmake glibc automake numactl numactl-devel libaio libaio-devel perl perl-Data-Dumper wget vim', shell=True)
    subprocess.call('wget {}'.format(mysql_url), shell=True)
    subprocess.call('tar -zxvf {}'.format(mysql_file), shell=True)
    subprocess.call('./{} cmake -DCMAKE_INSTALL_PREFIX=/usr/local/src/mysql -DINSTALL_SBINDIR=/usr/local/src/mysql/bin -DINSTALL_BINDIR=/usr/local/src/mysql/bin -DMYSQL_DATADIR=/usr/local/src/mysql/data -DINSTALL_SCRIPTDIR=/usr/local/src/mysql/bin -DSYSCONFDIR=/etc -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_EXTRA_CHARSETS=all -DDOWNLOAD_BOOST=1 -DWITH_BOOST=/usr/local/src/boost -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_EXAMPLE_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DENABLED_PROFILING=1 -DWITH_SSL=bundled -DWITH_SSL_PATH=/usr/include/openssl -DWITH_ZLIB=system -DMYSQL_TCP_PORT=3306 -DCURSES_LIBRARY=/usr/lib64/libncurses.so -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DENABLED_LOCAL_INFILE=1 -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DCURSES_INCLUDE_PATH=/usr/include'.format(mysql_dir), shell=True)
    subprocess.call('make', shell=True)
    subprocess.call('make install', shell=True) 

else:
    mysql_version = sys.argv[1]
    mysql_dir = 'mysql-{}-el7-x86_64'.format(mysql_version)
    mysql_url = 'https://downloads.mysql.com/archives/get/p/23/file/mysql-{}-el7-x86_64.tar.gz'.format(mysql_version)
    mysql_file = 'mysql-{}-el7-x86_64.tar.gz'.format(mysql_version)
    subprocess.call('yum install -y cmake ncurses ncurses-devel ncurses-libs ncurses-static openssl openssl-devel bison readline gcc gcc-c++ make cmake glibc automake numactl numactl-devel libaio libaio-devel perl perl-Data-Dumper wget vim', shell=True)
    subprocess.call('wget {}'.format(mysql_url), shell=True)
    subprocess.call('tar -zxvf {}'.format(mysql_file), shell=True)
    subprocess.call('./{} cmake -DCMAKE_INSTALL_PREFIX=/usr/local/src/mysql -DINSTALL_SBINDIR=/usr/local/src/mysql/bin -DINSTALL_BINDIR=/usr/local/src/mysql/bin -DMYSQL_DATADIR=/usr/local/src/mysql/data -DINSTALL_SCRIPTDIR=/usr/local/src/mysql/bin -DSYSCONFDIR=/etc -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_EXTRA_CHARSETS=all -DDOWNLOAD_BOOST=1 -DWITH_BOOST=/usr/local/src/boost -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_EXAMPLE_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DENABLED_PROFILING=1 -DWITH_SSL=bundled -DWITH_SSL_PATH=/usr/include/openssl -DWITH_ZLIB=system -DMYSQL_TCP_PORT=3306 -DCURSES_LIBRARY=/usr/lib64/libncurses.so -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DENABLED_LOCAL_INFILE=1 -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DCURSES_INCLUDE_PATH=/usr/include'.format(mysql_dir), shell=True)
    subprocess.call('make', shell=True)
    subprocess.call('make install', shell=True) 