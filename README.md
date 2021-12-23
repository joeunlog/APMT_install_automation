# APMT install automation

- 서형덕 shd5176@gmail.com
- 조은빛 j.eunvit@gmail.com
- 권영인 gds9210@gmail.com
- 김연수 james6852311@gmail.com

### < 소통 >
Google Chat  

### < 자료 공유 >
Github repository  

### < 작업 >
1. 계획  
  1.1 WBS					# 김연수	~ 10/28  
  1.2 명세서				# 조은빛	~ 10/29  
  1.3 구성도				# 권영인	~ 10/29  
2. 파악  
  2.1 기존에 작성한 Ansible playbook 파악	# All	~ 11/3  
3. Ansible only version    
  3.1 EC2 key 적용				# 조은빛	~ 11/12  
  3.2 MySQL 설치 자동화			# 권영인	~ 11/12  
  3.3 php 설치 자동화			# 김연수	~ 11/12  
  3.4 manual 작성				# All	~ 11/12  
4. Script version  
  4.1 Shell script  
    4.1.1 Apache				# 조은빛	~ 11/26  
    4.1.2 php				# 조은빛	~ 11/26  
    4.1.3 MySQL				# 조은빛	~ 11/26  
    4.1.4 Tomcat				# 조은빛	~ 11/26  
  4.2 Python  
    4.2.1 Apache				# 권영인	~ 11/26  
    4.2.2 php				# 김연수	~ 11/26  
    4.2.3 MySQL				# 김연수	~ 11/26  
    4.2.4 Tomcat				# 권영인	~ 11/26  
  4.3 Ansible				# All	~ 11/26  
  4.4 Manual 작성				# All	~ 11/26  

### < 설치 환경 통일 >
ex. apache  
설치 주소 : /usr/local/src/apache  
압축 파일 디렉토리 : /usr/local/src/apache-2.4.46.tar.gz  

---------
# 일일 진행 상황
- 2021-10-28  
  - 프로젝트 컨셉 회의 - 자동화 스크립트 언어 결정 및 업무 분담
  - WBS 초안 작성
- 2021-10-29
  - 테스트 환경 구성 회의
  - 명세서 초안 작성
  - 구성도 초안 작성
  - 테스트 환경 구축
- 2021-11-01
  - ec2 생성용 Ansible yaml 파일 작성 (keypair 적용)
  - ec2 info 확인용 ansible yaml 파일 작성
- 2021-11-02
  - architecture에 따른 각 서버용 instance 생성 ansible 작성 완료
  - instance 생성, apache 설치, tomcat 설치까지 테스트 완료
- 2021-11-03
  - instance 생성 후 mysql 설치용 ansible yaml 파일 작성 완료
  - mysql 설치 및 테스트 완료
- 2021-11-04
  - ansible only 버전 매뉴얼 초안 작성
  - ansible only 버전 php 설치용 ansible-playbook 작성, 테스트 완료
  - ansible script 버전 apache 설치 python 스크립트 작성 중
- 2021-11-05
  - ansible only 버전 매뉴얼 작성
  - ansible script 버전 apache,php 설치 python 스크립트 작성 중
- 2021-11-08
  - apache tomcat python script, ansible-playbook 완료