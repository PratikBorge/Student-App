FROM centos:7

LABEL engg="pratborge"

USER root

# Fix CentOS 7 repositories
RUN sed -i 's|mirrorlist.centos.org|vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo \
    && sed -i 's|#.*baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo \
    && yum clean all \
    && yum makecache

# Install Apache
RUN yum install -y httpd \
    && yum clean all

COPY proxy.conf /etc/httpd/conf.d/proxy.conf

COPY index.html /var/www/html/index.html

RUN chmod 664 /var/www/html/index.html

EXPOSE 80

CMD ["httpd", "-DFOREGROUND"]
