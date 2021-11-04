###################################################
#용도
#AWS CLI 써서 테스트 ec2 Amazon Linux2 기본 셋팅을 손쉽게 만들수있습니다. 

#필요사항 
#AWS Secret Key 값 
#AWS Access Key 값 
#AWS Region (ap-northeast-2 기본값) 
# vpc 셋팅 10.70.0.0/16 기본값
# Subnet 셋팅 10.70.10.0/24
###################################################

#!/bin/bash
CDIR=$(pwd)
#CDIR 현재위치 
#중복된 키값 확인 

function check_Keyname(){
 touch $CDIR/reset
 cat $CDIR/reset > $CDIR/loopcount
 echo -e "Insert Key_name :  "
 read word
 echo "Key Name : $word "

 array_name=("")

 aws ec2 describe-key-pairs | grep KeyName | cut -d'"' -f4 > $CDIR/Keyname

 keynumber=$(cat $CDIR/Keyname | wc -l)
 for((t=1; t<=$keynumber; t++))
 do
  KeyInsert=$(cat $CDIR/Keyname | head -$t | tail -1)
  array_name+=($KeyInsert)
 done
 for((tmp=1; tmp<=$keynumber; tmp++))
 do
  data=${array_name[$tmp]}
  if [[ $data == $word ]]; then
   break
  else
   echo $tmp >> $CDIR/loopcount
  fi
 done
 tmp6=$(cat $CDIR/loopcount | wc -l)
 if [[ $tmp6 == $keynumber ]]; then
  echo "Key created"
  aws ec2 create-key-pair --key-name $word --query "KeyMaterial" --output text > $CDIR/$word
  #cat $CDIR/$word.pem > $CDIR/$word
 else
  echo "Key name exists please try again"
  check_Keyname
 fi
}

echo "secret key :"
aws configure get aws_secret_access_key
echo "access key :"
aws configure get aws_access_key_id

#aws configure secretkey 와 access_key_id 확인하기 

aws configure
#aws configure secretkey, access_key_id ,리전 설정

aws ec2 create-vpc --cidr-block 10.70.0.0/16 > $CDIR/tmp
#vpc 생성

varvpcid=$(cat tmp | grep VpcId | cut -d'"' -f4)
echo $varvpcid

aws ec2 create-subnet --vpc-id $varvpcid --cidr-block 10.70.10.0/24 --availability-zone ap-northeast-2c | grep SubnetId >$CDIR/subnet1
aws ec2 create-subnet --vpc-id $varvpcid --cidr-block 10.70.20.0/24 --availability-zone ap-northeast-2c | grep SubnetId >$CDIR/subnet2
#subnet 생성
varsubnet1=$(cat subnet1 | grep SubnetId | cut -d'"' -f4)
varsubnet2=$(cat subnet2 | grep SubnetId | cut -d'"' -f4)

echo $varsubnet1
echo $varsubnet2

aws ec2 create-internet-gateway >$CDIR/tmp3

#internetgateway 생성
echo 'ig created;'
varinternetgateway1=$(cat $CDIR/tmp3 | grep InternetGatewayId | cut -d'"' -f4)

aws ec2 attach-internet-gateway --vpc-id $varvpcid --internet-gateway-id $varinternetgateway1
echo 'ig attached'
#internetgateway vpc 연결

aws ec2 create-route-table --vpc-id $varvpcid  > $CDIR/tmp4
#routetable 생성

echo 'routetable created'
varroutetable1=$(cat $CDIR/tmp4 | grep RouteTableId | cut -d'"' -f4)

aws ec2 associate-route-table --subnet-id $varsubnet1 --route-table-id $varroutetable1
aws ec2 associate-route-table --subnet-id $varsubnet2 --route-table-id $varroutetable1
#route table subnet 연결

aws ec2 create-route --route-table-id $varroutetable1 --destination-cidr-block 0.0.0.0/0 --gateway-id $varinternetgateway1
#route table ig 연결

check_Keyname
#Key 생성및 중복 함수 실행

aws ec2 create-security-group --description "ssh_test" --group-name ssh --vpc-id $varvpcid > $CDIR/tmp5
#sg 생성

varsecurity_group1=$(cat $CDIR/tmp5 | grep GroupId | cut -d'"' -f4)

aws ec2 authorize-security-group-ingress --group-id $varsecurity_group1 --protocol tcp --port 22 --cidr 0.0.0.0/0
#sg 설정

aws ec2 run-instances --image-id ami-0a0de518b1fc4524c --key-name $word --security-group-ids $varsecurity_group1 --instance-type t2.micro --subnet-id $varsubnet1 --associate-public-ip-address --query 'Instances[*].InstanceId'
#ec2 생성 

rm -rf $CDIR/subnet1
rm -rf $CDIR/subnet2
rm -rf $CDIR/tmp*

chmod 400 $CDIR/$word
#Key 값 권한 

#ssh -i (입력된 pem {$word}) (초기설정아이디)@(해당ip) 
#ec2 접근 명령어