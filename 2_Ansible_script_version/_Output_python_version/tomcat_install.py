#!/usr/bin/env python
import os
import sys

# input version
tomcat_version = sys.argv[1]

# install dependency package
print("-------------------------install dependency package-------------------------")
os.system("yum -y install java-openjdk wget vim")



# move path
os.chdir('/usr/local/src')

# download tomcat
print("-----------------------------download tomcat-----------------------------")
url_tomcat_download = "wget https://archive.apache.org/dist/tomcat/tomcat-8/v{}/bin/apache-tomcat-{}.tar.gz".format(tomcat_version, tomcat_version)
os.system(url_tomcat_download)

# extract tomcat
print("-----------------------------extract tomcat-----------------------------")
extract_tomcat = "tar xzvf apache-tomcat-{}.tar.gz".format(tomcat_version)
os.system(extract_tomcat)

# start tomcat services
print("-----------------------------start tomcat services-----------------------------")
os.system("nohup /usr/local/src/apache-tomcat-8.5.66/bin/catalina.sh start ")