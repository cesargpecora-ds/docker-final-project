FROM ubuntu:14.04.2

MAINTAINER Cesar Garcia <cgarcia@devspark.com>

# Update OS, Install apache, PHP, and supplimentary programs.
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install apache2 libapache2-mod-php5 php5-mysql php5-gd php-pear php-apc php5-curl curl lynx-cur

# Enable apache mods.
RUN a2enmod php5
RUN a2enmod rewrite

# Set up the environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV WORLD_API_DOCUMENT_ROOT /opt/www/worldapi/public/
ENV WORLD_API_SERVER_NAME api.world.com.ar

# Expose Apache port
EXPOSE 80

# Copy the Apache config file
ADD apache2.conf /etc/apache2/apache2.conf

# Copy the application Virtual host config
ADD worldapi.conf /etc/apache2/sites-available/worldapi.conf

# Enable Virtual Host config
RUN a2ensite worldapi.conf

# Set up DB using entrypoint.sh bash script
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh

# Finally, run the Apache default application 
CMD /usr/sbin/apache2ctl -D FOREGROUND
