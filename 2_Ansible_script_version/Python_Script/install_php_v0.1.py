#!/usr/bin/env python

print('#'*30)
print("Php download start")
print('#'*30)

import subprocess
import sys
php_version = sys.argv[1]
user_url = sys.argv[1]
if 'https' or 'www' or 'tar.gz' in sys.argv[1]:
    

php_dir = 'php-{}'.format(php_version)
url_php = 'https://www.php.net/distributions/php-{}.tar.gz'.format(php_version)
php_file = 'php-{}.tar.gz'.format(php_version)
subprocess.call('yum -y install wget libxml2-devel openssl-devel libjpeg-devel libpng-devel vim', shell=True)
subprocess.call('wget {}'.format(url_php), shell=True)
subprocess.call('tar -zxvf {}'.format(php_file), shell=True)
subprocess.call('./{}/configure --prefix=/usr/local/src/php --with-apxs=/usr/local/apache/bin/apxs --with-mysql --with-mysqli --with-zlib --with-jpeg --with-png --with-openssl --with-libxml --with-iconv --with-gd --enable-curl --enable-sockets --disable-fileinfo --disable-debug'.format(php_dir), shell=True)
subprocess.call('make', shell=True)
subprocess.call('make install', shell=True) 
0 