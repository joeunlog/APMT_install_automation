url = 'https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.24-el7-x86_64.tar.gz'

print(url[url.find('mysql-') : url.find('-el7')])


url2 = 'https://www.php.net/distributions/php-7.7.30.tar.gz'
print(url2[url2.find('php-') : url2.find('.tar')])
