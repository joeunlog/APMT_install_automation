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
subprocess.call('yum -y install libxml2-devel openssl-devel libjpeg-devel libpng-devel vim', shell=True)

php_version = print(input('which version you going to install? : '))
user_ans = print(input('Php version = ', php_version, 'correct? (yes/no)'))
if user_ans == 'yes':
    url_php = 'https://www.php.net/distributions/php-7.3.32.tar.gz'
    subprocess.call('wget ')