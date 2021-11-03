# APMT install automation
## yum install version - ansible

- VPC, Subnet, SG 등을 미리 구축한 뒤 각 서버용 EC2 instance는 ansible 이용하여 따로 구축
- bastion server는 콘솔에서 생성, 아래 작업은 모두 bastion 서버에서 진행
- bastion server에 이 디렉토리의 파일과 각 서버 접속용 keypair가 있어야 함
<br>
<br>
<br>

---
# Install ansible
```sh
yum -y install epel-release
yum -y install ansible
```

---
# Install pip, boto - at bastion server
`pip_boto_install.yml`
```sh
ansible-playbook pip_boto_install.yml -i hosts
```

---
# Set aws variable
```sh
export AWS_ACCESS_KEY_ID=''
export AWS_SECRET_ACCESS_KEY=''
```


---
# Create ec2 instance with keypair
`ec2_create.yaml`
```sh
ansible-playbook ec2_create.yaml -i hosts
```

---
# Install httpd (apache) to web server
`httpd_install.yaml`
```sh
ansible-playbook httpd_install.yaml -i aws_hosts
```
> curl test : `curl 10.50.20.15`, `curl 10.50.20.150`

---
# Install tomcat to was server
`tomcat_install.yaml`
```sh
ansible-playbook tomcat_install.yaml -i aws_hosts
```
> curl test : `curl 10.50.30.15:8080`, `curl 10.50.30.150:8080`

---
# Install mysql to db server


> instance type의 경우 t2.micro로는 정상적으로 설치되지 않고 t3.small에서는 정상 설치
> 마찬가지로, EBS 용량 8 GiB에서는 에러가 나고 30 GiB에서는 정상 설치