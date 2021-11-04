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

php_version=input('which version you going to install? : ')
print('Php version = ', php_version, 'correct? (yes/no)')
user_ans=input(':')
if user_ans == 'yes':
    urlphp = 'https://www.php.net/distributions/php-'+php_version+'.tar.gz'
    print(urlphp)
    subprocess.call(['wget ' ,print(urlphp)], shell=True)