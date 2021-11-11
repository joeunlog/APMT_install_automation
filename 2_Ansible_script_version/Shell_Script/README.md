# APMT install automation - Ansible Script version
## Shell

---

# PCRE URL issue  

```sh
# wget -P . https://ftp.pcre.org/pub/pcre/pcre-${pcrever}.tar.gz --no-check-certificate
# 위 코드의 URL이 정상 작동하지 않아서 아래로 변경 필요
wget -P . https://sourceforge.net/projects/pcre/files/pcre/${pcrever}/pcre-${pcrever}.tar.gz --no-check-certificate
```


# Check installed package issue

```sh
######################## gcc, gcc-c++ ##########################
# check gcc installed
# if not, install gcc
yum list installed | grep ^gcc.x86_64
if [ $? -ne 0 ]
then
    echo -e "\e[1;34m=======================================================\e[0m"
    echo -e "\e[1;44m[ There is no gcc, now install ]\e[0m"
    yum install -y gcc
fi

# check gcc-c++ installed
# if not, install gcc-c++
yum list installed | grep ^gcc-c++.x86_64
if [ $? -ne 0 ]
then
    echo -e "\e[1;34m=======================================================\e[0m"
    echo -e "\e[1;44m[ There is no gcc-c++, now install ]\e[0m"
    yum install -y gcc-c++
fi
```



# Ubuntu OS

yum -> apt-get  
apt-get list installed / apt --installed list