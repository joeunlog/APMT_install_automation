# APMT install automation
## yum install version - ansible

VPC, Subnet, SG 등을 미리 구축한 뒤 EC2는 ansible 이용하여 따로 구축
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
> curl test : `curl 10.50.20.15:8080`, `curl 10.50.20.150:8080`