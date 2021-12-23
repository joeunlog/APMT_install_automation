# APMT install automation
## Ansible + shell script version

- VPC, Subnet, SG 등을 미리 구축한 뒤 각 서버용 EC2 instance는 ansible 이용하여 따로 구축
- bastion server는 콘솔에서 생성, 아래 작업은 모두 bastion 서버에서 진행
- bastion server에 이 디렉토리의 파일과 각 서버 접속용 keypair가 있어야 함  
</br>

정식 매뉴얼은 구글 드라이브에

</br>

---
# Install ansible
```sh
yum -y install epel-release
yum -y install ansible
```
</br>

---
# Install pip, boto - at bastion server
`pip_boto_install.yml`
```sh
ansible-playbook pip_boto_install.yml -i hosts
```
</br>

---
# Set aws variable
> AWS IAM - User - 보안자격증명에서 키 발급 받아서 적용
```sh
export AWS_ACCESS_KEY_ID=''
export AWS_SECRET_ACCESS_KEY=''
```
</br>

---
# Create ec2 instance with keypair
`ec2_create.yaml`
```sh
ansible-playbook ec2_create.yaml
```
</br>
  
---
# Do not ask ssh connection
'/etc/ssh/ssh_config'
```
Host * # 이 부분에 아래 줄 추가
StrictHostKeyChecking no
```
</br>

---
# Install httpd (apache) to web server
`apache_install_sh.yaml`
```sh
ansible-playbook apache_install_sh.yaml -i ansible_hosts_sh
```

</br>

---
# Install tomcat to was server
`tomcat_install_sh.yaml`
```sh
ansible-playbook tomcat_install_sh.yaml -i ansible_hosts_sh
```

</br>

---
# Install php to web server
`php_install_sh.yaml`
```sh
ansible-playbook php_install_sh.yaml -i ansible_hosts_sh
```

</br>

---
# Install mysql to db server
`mysql_install_sh.yaml`
```sh
ansible-playbook mysql_install_sh.yaml -i ansible_hosts_sh
```

> instance type의 경우 t2.micro로는 정상적으로 설치되지 않고 t3.small에서는 정상 설치  
> 마찬가지로, EBS 용량 8 GiB에서는 에러가 나고 30 GiB에서는 정상 설치

</br>