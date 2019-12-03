FROM ubuntu:16.04
MAINTAINER GarretSidzaka <GarretSidzaka@2enp.com>

VOLUME ["/var/www"]

RUN apt-get update && \
    apt-get purge `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "` && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/* && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \    
    apt-get install -y \
      apache2 \
      php5.6 \
      php5.6-mbstring \
      php5.6-mcrypt \
      php5.6-mysql \
      php5.6-xml \
      php5.6-cli \
      php5.6-common \
      php5.6-cgi && \
    mkdir /etc/apache2/ssl && \
    mkdir /etc/apache2/ssl/private && \
    chmod 755 /etc/apache2/ssl && \
    chmod 710 /etc/apache2/ssl/private

COPY run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN a2enmod rewrite

EXPOSE 80
EXPOSE 443
CMD ["/usr/local/bin/run"]
