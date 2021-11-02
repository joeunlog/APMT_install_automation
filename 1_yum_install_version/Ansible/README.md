# APMT install automation
## yum install version - ansible

VPC, Subnet, SG 등을 미리 구축한 뒤 EC2는 ansible 이용하여 따로 구축
<br>
<br>
<br>

---
# Install ansible

yum -y install epel-release
yum -y install ansible


---
# Install pip, boto - at bastion server
`pip_boto_install.yml`
```sh
ansible-playbook pip_boto_install.yml -i hosts
```


<br>
<br>

---
# Create ec2 instance with keypair

- web01 server
    - region: "ap-southeast-1"
    - key_name: "keypair-auto-dev-pri"
    - instance_type: "t2.micro"
    - image: "ami-07f65177cb990d65b"
    - wait: yes
    - group: "sg_auto_dev_ase1_pri_web"
    - vpc_subnet_id: "subnet-07513a160e196ab2c" (ase1-a-pri-web01)
    - private_ip: "10.50.20.15"
    - instance_tags:
        - Name: ec2-auto-dev-ase1-pri-web01
        - Creater: Ansible
    - termination_protection: yes
- web02 server
    - region: "ap-southeast-1"
    - key_name: "keypair-auto-dev-pri"
    - instance_type: "t2.micro"
    - image: "ami-07f65177cb990d65b"
    - wait: yes
    - group: "sg_auto_dev_ase1_pri_web"
    - vpc_subnet_id: "subnet-04aa748ecbd274282" (ase1-c-pri-web02)
    - private_ip: "10.50.20.150"
    - instance_tags:
        - Name: ec2-auto-dev-ase1-pri-web02
        - Creater: Ansible    
    - termination_protection: yes        
- was01 server
    - region: "ap-southeast-1"
    - key_name: "keypair-auto-dev-pri"
    - instance_type: "t2.micro"
    - image: "ami-07f65177cb990d65b"
    - wait: yes
    - group: "sg_auto_dev_ase1_pri_was"
    - vpc_subnet_id: "subnet-0314d1050e78e756d" (ase1-a-pri-was01)
    - private_ip: "10.50.30.15"
    - instance_tags:
        - Name: ec2-auto-dev-ase1-pri-was01
        - Creater: Ansible    
    - termination_protection: yes        
- was02 server
    - region: "ap-southeast-1"
    - key_name: "keypair-auto-dev-pri"
    - instance_type: "t2.micro"
    - image: "ami-07f65177cb990d65b"
    - wait: yes
    - group: "sg_auto_dev_ase1_pri_was"
    - vpc_subnet_id: "subnet-02c882929c6af35da" (ase1-c-pri-was02)
    - private_ip: "10.50.30.150"
    - instance_tags:
        - Name: ec2-auto-dev-ase1-pri-was02
        - Creater: Ansible    
    - termination_protection: yes        
- db server
    - region: "ap-southeast-1"
    - key_name: "keypair-auto-dev-pri"
    - instance_type: "t3.small"
    - image: "ami-07f65177cb990d65b"
    - wait: yes
    - group: "sg_auto_dev_ase1_pri_db"
    - vpc_subnet_id: "subnet-06bfe2354cfd206a1" (ase1-a-pri-db01)
    - private_ip: "10.50.100.15"
    - instance_tags:
        - Name: ec2-auto-dev-ase1-pri-db
        - Creater: Ansible
    - termination_protection: yes            



