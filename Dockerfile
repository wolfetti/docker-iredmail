FROM debian:buster-slim

# Initial required packages
RUN apt-get update && apt-get -y --no-install-recommends install \
  s6 wget procps ca-certificates rsyslog

ENV DOMAIN=DOMAIN
ENV HOSTNAME=HOSTNAME

# MySQL database
ENV MYSQL_HOST=""
ENV MYSQL_PORT=""

# Database passwords. If points to a file then is used it's content
ENV AMAVISD_DB_PASSWD=""
ENV IREDADMIN_DB_PASSWD=""
ENV IREDAPD_DB_PASSWD=""
ENV ROUNDCUBE_DB_PASSWD=""
ENV VMAIL_DB_PASSWD=""
ENV VMAIL_ADMIN_DB_PASSWD=""

VOLUME /var/vmail

# Download and prepare iRedMail installer
RUN wget https://github.com/iredmail/iRedMail/archive/1.1.tar.gz -O /tmp/iRedMail-1.1.tar.gz \
  && tar -xzvf /tmp/iRedMail-1.1.tar.gz -C /tmp/ \
  && sed -i "s/mariadb-server//" /tmp/iRedMail-1.1/functions/packages.sh \
  && chmod +x /tmp/iRedMail-1.1/iRedMail.sh

# iRedMail installer configuration
COPY ./iredmail/config /tmp/iRedMail-1.1/config

# Run installer
RUN IREDMAIL_DEBUG='NO' \
   IREDMAIL_HOSTNAME="HOSTNAME.DOMAIN" \
   AUTO_USE_EXISTING_CONFIG_FILE=y \
   AUTO_INSTALL_WITHOUT_CONFIRM=y \
   AUTO_CLEANUP_REMOVE_SENDMAIL=y \
   AUTO_CLEANUP_REMOVE_MOD_PYTHON=y \
   AUTO_CLEANUP_REPLACE_FIREWALL_RULES=n \
   AUTO_CLEANUP_RESTART_IPTABLES=n \
   AUTO_CLEANUP_REPLACE_MYSQL_CONFIG=y \
   AUTO_CLEANUP_RESTART_POSTFIX=n \
   CHECK_NEW_IREDMAIL='NO' \
   bash /tmp/iRedMail-1.1/iRedMail.sh
   
# Removing logwatch
RUN apt-get -y remove logwatch && apt-get -y autoremove

# Installing roundcubemail extra plugins
RUN wget -O - https://getcomposer.org/installer | php \
  && mv composer.phar /usr/bin/composer \
  && cd /opt/www/roundcubemail \
  && apt-get -y install php-ldap \
  && /usr/bin/composer require --update-no-dev \
    "roundcube/carddav:*"  \
  && echo "array_push(\$config['plugins'], 'carddav');" \ 
     >> /opt/www/roundcubemail/config/config.inc.php

# s6 services
COPY ./services /services

# Utility scripts
ADD ./sh/generate_ssl_keys.sh /

# Start entrypoint setup
ADD ./sh/start.sh /
RUN chmod +x /start.sh \
  && apt-get -y clean \
  && rm -rf /tmp/iRedMail* \
  && rm -rf /var/lib/apt/lists/*

# DEV env vars
ENV DEV_SKIP_UPDATE_CLAM_DB_ON_STARTUP="NO"

# Starting mechanism
ENTRYPOINT ["/start.sh"]
CMD []

# Open Ports:
# Apache: 80/tcp, 443/tcp Postfix: 25/tcp, 587/tcp
# Dovecot: 110/tcp, 143/tcp, 993/tcp, 995/tcp
EXPOSE 80 443 25 587 110 143 993 995
