version = input('put version : ')
if 'https' or 'www' or 'tar.gz' in version:
    user_url = version
    print(user_url)

if len(version) < 7:
    php_version = version
    url_php = 'https://www.php.net/distributions/php-{}.tar.gz'.format(php_version)
    print(url_php)