#!/usr/bin/env python

import subprocess #shell 명령어 사용 시 필요
import sys #ansible에서 인자값 받아오기 위해 필요

#ansible-playbook 실행시 url을 입력하면 실행
version = sys.argv[1]
if 'https' or 'www' or 'tar.gz' in version:
    user_url = version
    php_dir = user_url[user_url.find('php-') : user_url.find('.tar')]
    php_file = user_url[user_url.find('php-') : ]
    php_path = '/usr/local/src/{}'.format(php_dir)
    subprocess.call('chdir /usr/local/src', shell=True)
    subprocess.call('yum -y install wget libxml2-devel openssl-devel libjpeg-devel libpng-devel vim', shell=True)
    subprocess.call('wget {}'.format(user_url), shell=True)
    subprocess.call('tar zxvf {}'.format(php_file), shell=True)
    subprocess.call('chdir {}'.format(php_dir), shell=True)
    subprocess.call('./configure --prefix=/usr/local/src/php --with-apxs=/usr/local/apache/bin/apxs --with-mysql --with-mysqli --with-zlib --with-jpeg --with-png --with-openssl --with-libxml --with-iconv --with-gd --enable-curl --enable-sockets --disable-fileinfo --disable-debug', shell=True)
    subprocess.call('make', shell=True)
    subprocess.call('make install', shell=True)

#url이 아니라 버전만 입력했을 시 실행
if len(version) < 7:
    php_version = version
    php_dir = 'php-{}'.format(php_version)
    url_php = 'https://www.php.net/distributions/php-{}.tar.gz'.format(php_version)
    php_file = 'php-{}.tar.gz'.format(php_version)
    php_path = '/usr/local/src/{}'.format(php_dir)
    subprocess.call('chdir /usr/local/src', shell=True)
    subprocess.call('yum -y install wget libxml2-devel openssl-devel libjpeg-devel libpng-devel vim', shell=True)
    subprocess.call('wget {}'.format(url_php), shell=True)
    subprocess.call('tar zxvf {}'.format(php_file), shell=True)
    subprocess.call('chdir {}'.format(php_dir), shell=True)
    subprocess.call('{}/configure --prefix=/usr/local/src/php --with-apxs=/usr/local/apache/bin/apxs --with-mysql --with-mysqli --with-zlib --with-jpeg --with-png --with-openssl --with-libxml --with-iconv --with-gd --enable-curl --enable-sockets --disable-fileinfo --disable-debug'.format(php_path), shell=True)
    subprocess.call('make', shell=True)
    subprocess.call('make install', shell=True)

else:
    print('install fail')