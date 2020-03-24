FROM debian:buster-slim

RUN apt-get update && apt-get -y install s6 wget

# Default values changable at startup
ENV FQDN="mail-server.example.com"
ENV MYSQL_HOST=""
ENV MYSQL_PORT=3306
ENV TZ="Europe/Rome"

ENV AMAVISD_DB_USER="amavisd"
ENV AMAVISD_DB_PASSWD=""
ENV AMAVISD_DB_PASSWD_FILE="/run/secrets/iredmail_amavisd_mysql_password"

ENV IREDADMIN_DB_USER="iredadmin"
ENV IREDADMIN_DB_PASSWD=""
ENV IREDADMIN_DB_PASSWD_FILE="/run/secrets/iredmail_iredadmin_mysql_password"

ENV IREDAPD_DB_USER="iredapd"
ENV IREDAPD_DB_PASSWD=""
ENV IREDAPD_DB_PASSWD_FILE="/run/secrets/iredmail_iredapd_mysql_password"

ENV ROUNDCUBE_DB_USER="roundcubemail"
ENV ROUNDCUBE_DB_PASSWD=""
ENV ROUNDCUBE_DB_PASSWD_FILE="/run/secrets/iredmail_roundcube_mysql_password"

ENV SOGO_DB_USER="sogo"
ENV SOGO_DB_PASSWD=""
ENV SOGO_DB_PASSWD_FILE="/run/secrets/iredmail_sogo_mysql_password"

ENV VMAIL_DB_USER="vmail"
ENV VMAIL_DB_PASSWD=""
ENV VMAIL_DB_PASSWD_FILE="/run/secrets/iredmail_vmail_mysql_password"

ENV VMAILADMIN_DB_USER="vmailadmin"
ENV VMAILADMIN_DB_PASSWD=""
ENV VMAILADMIN_DB_PASSWD_FILE="/run/secrets/iredmail_vmailadmin_mysql_password"

VOLUME /iredmail

ADD ./etc /iredmail/etc/

ARG IREDMAIL_VERSION=1.1
ARG FQDN="mail-server.frijofabio.com"
ARG INSTALLER=/tmp/iRedMail-${IREDMAIL_VERSION}/iRedMail/iRedMail.sh

RUN wget -O /tmp/iRedMail.tgz https://codeload.github.com/iredmail/iRedMail/tar.gz/"${IREDMAIL_VERSION}"
RUN cd /tmp && tar -xzvf /tmp/iRedMail.tgz && cd && chmod +x ${INSTALLER}

RUN IREDMAIL_DEBUG='NO' \
   IREDMAIL_HOSTNAME="${FQDN}" \
   CHECK_NEW_IREDMAIL='NO' \
   AUTO_USE_EXISTING_CONFIG_FILE=y \
   AUTO_INSTALL_WITHOUT_CONFIRM=y \
   AUTO_CLEANUP_REMOVE_SENDMAIL=y \
   AUTO_CLEANUP_REMOVE_MOD_PYTHON=y \
   AUTO_CLEANUP_REPLACE_FIREWALL_RULES=n \
   AUTO_CLEANUP_RESTART_IPTABLES=n \
   AUTO_CLEANUP_REPLACE_MYSQL_CONFIG=y \
   AUTO_CLEANUP_RESTART_POSTFIX=n \
   bash ${INSTALLER}

RUN apt-get -y clean && rm -rf /tmp/iRedMail*

# Starting mechanism
ENTRYPOINT ["/start.sh"]
CMD []

# Open Ports:
# Apache: 80/tcp, 443/tcp Postfix: 25/tcp, 587/tcp
# Dovecot: 110/tcp, 143/tcp, 993/tcp, 995/tcp
EXPOSE 80 443 25 587 110 143 993 995
