print("hello world")
print("## key값 보내는 방법 조사 시작합니다. - 연수 - ")
print("mySQL 설치 자료 조사 시작합니다.")
print("test test")

php_version=input('which version you going to install? : ')
print('Php version = ', php_version, 'correct? (yes/no)')
user_ans=input(':')
if user_ans == 'yes':
    url_php = 'https://www.php.net/distributions/php-'+php_version+'.tar.gz'
    print(url_php)

    