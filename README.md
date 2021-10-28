# APMT install automation

- 서형덕 shd5176@gmail.com
- 조은빛 j.eunvit@gmail.com
- 권영인 gds9210@gmail.com
- 김연수



< 소통 >  
Google Chat  

< 자료 공유 >  
Github repository  

< 작업 >  
    1. 계획  
	1.1 WBS					# 김연수	~ 10/28  
	1.2 명세서				# 조은빛	~ 10/29  
	1.3 구성도				# 권영인	~ 10/29  
    2. 파악  
	2.1 기존에 작성한 Ansible playbook 파악	# All	~ 11/3  
    3. '구축' (가제)  
	3.1 EC2 key 적용				# 조은빛	~ 11/12  
	3.2 MySQL 설치 자동화			# 권영인	~ 11/12  
	3.3 php 설치 자동화			# 김연수	~ 11/12  
	3.4 manual 작성				# All	~ 11/12  
    4. Script 고도화 - 버전 선택 기능 추가  
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

< 설치 환경 통일 >  
ex. apache  
설치 주소 : /usr/local/src/apache  
압축 파일 디렉토리 : /usr/local/setup/apache-2.4.46.tar.gz  