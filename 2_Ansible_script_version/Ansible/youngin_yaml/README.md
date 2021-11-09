# Ansible 실행 시 Python argv를 넣어 실행
## 1) HTTPD 설치
* 예시 ->  `ansible_host` 파일에서 지정된 호스트에 각 버전을 지정하여 미들웨어를 할 수 있음
```
ansible-playbook httpd_install_py.yml -i ansible_hosts -e 'APACHE_VERSION=2.4.46 APR_VERSION=1.6.5 APR_UTIL_VERSION=1.6.1 PCRE_VERSION=8.44'
```

## 2) TOMCAT 설치
* 예시
```
ansible-playbook tomcat_install_py.yml -i ansible_hosts -e 'TOMCAT_VERSION=8.5.66'
```
