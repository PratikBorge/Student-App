FROM centos:7

LABEL engg="pratborge"

USER root

# Fix CentOS 7 repositories
RUN sed -i 's|mirrorlist.centos.org|vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo \
    && sed -i 's|#.*baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo \
    && yum clean all \
    && yum makecache

# Install Java
RUN yum install -y java \
    && yum clean all

WORKDIR /opt/

# Download Tomcat
ADD https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.100/bin/apache-tomcat-8.5.100.tar.gz .

RUN tar -xzvf apache-tomcat-8.5.100.tar.gz \
    && rm apache-tomcat-8.5.100.tar.gz

WORKDIR /opt/apache-tomcat-8.5.100

# Application WAR
ADD https://artifactforthreeprat.s3.ap-southeast-1.amazonaws.com/student.war webapps/student.war

# MySQL connector
ADD https://artifactforthreeprat.s3.ap-southeast-1.amazonaws.com/mysql-connector.jar lib/mysql-connector.jar

# Tomcat configuration
COPY context.xml conf/context.xml

EXPOSE 8080

CMD ["bin/catalina.sh", "run"]
