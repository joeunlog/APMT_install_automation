#!/usr/bin/env python

print('#'*30)
print("Php download start")
print('#'*30)

print("Checking dependency packages")
import subprocess
result = subprocess.call('rpm-qa | grep wget', shell=True)

if len(result) == 0:
    subprocess.call('yum -y install wget', shell=True)
    
subprocess.call('ls -l', shell=True)
subprocess.call('cd /usr/local/src')
subprocess.call('yum -y install wget libxml2-devel openssl-devel libjpeg-devel libpng-devel vim', shell=True)

while True:
    php_version = 0 , user_ans = 0, urlphp = 0
    php_version=input('which version you going to install? : ')
    print('Php version ={}'.format(php_version), 'correct? (yes/no)')
    user_ans=input(':')
    if user_ans == 'yes':
        urlphp = 'wget https://www.php.net/distributions/php-{}.tar.gz'.format(php_version)
        print(urlphp)
        subprocess.Popen(urlphp.split(), stdout=subprocess.PIPE )
        break
    if user_ans != 'yes':
        print('plz type your version again')
php_dir = 'php-{}'.format(php_version)
subprocess.Popen(['tar -zxvf {}'.format(php_dir)], stdout=subprocess.PIPE )
subprocess.Popen(['cd{}'.format(php_dir)])
subprocess.Popen(['./configure', '--prefix=/usr/local/src/php','--with-apxs=/usr/local/apache/bin/apxs', '--with-mysql --with-mysqli', '--with-zlib', '--with-jpeg' ,'--with-png', '--with-openssl', '--with-libxml', '--with-iconv', '--with-gd', '--enable-curl', '--enable-sockets', '--disable-fileinfo', '--disable-debug' ])
subprocess.call('make')
subprocess.call('make install')