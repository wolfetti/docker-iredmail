#!/bin/bash
set -e

echo "========================================================================="
echo "Preparing runtime...."
echo "========================================================================="

# =============================
# FUNCTIONS AND INNER VARIABLES
# =============================
GET_PASS_ERRORS=""

function get_pass() {
  local X=""

  if [ -f $1 ]; then
    X="$(cat $1)"
  else
    X=$1
  fi

  if [[ "$X" == "" ]]; then
    GET_PASS_ERRORS="$GET_PASS_ERRORS\n\t- $2"
  fi

  echo $X
}

# =============================
# LOADING USER ENV (OR SECRETS)
# =============================
REAL_AMAVISD_DB_PASSWD=$(get_pass $AMAVISD_DB_PASSWD "AMAVISD_DB_PASSWD")
REAL_IREDADMIN_DB_PASSWD=$(get_pass $IREDADMIN_DB_PASSWD "IREDADMIN_DB_PASSWD")
REAL_IREDAPD_DB_PASSWD=$(get_pass $IREDAPD_DB_PASSWD "IREDAPD_DB_PASSWD")
REAL_ROUNDCUBE_DB_PASSWD=$(get_pass $ROUNDCUBE_DB_PASSWD "ROUNDCUBE_DB_PASSWD")
REAL_VMAIL_DB_PASSWD=$(get_pass $VMAIL_DB_PASSWD "VMAIL_DB_PASSWD")
REAL_VMAIL_ADMIN_DB_PASSWD=$(get_pass $VMAIL_ADMIN_DB_PASSWD "VMAIL_ADMIN_DB_PASSWD")

if [[ "$GET_PASS_ERRORS" != "" ]]; then
  echo -e "The following required environment variables are missing:$GET_PASS_ERRORS"
  echo "This variables must be setted up and contains or the password, or to point to a password file (ex: /run/secrets/my_secret)"
  exit 1
fi

if [ -z $MYSQL_HOST ]; then
  echo "MySQL host name (or IP address) must be specified in environment variable MYSQL_HOST"
  exit 1
fi

if [ -z $MYSQL_PORT ]; then
  MYSQL_PORT=3306
fi

if [ -z $DOMAIN ]; then
  DOMAIN=$(hostname -d)
fi

if [ -z $HOSTNAME ]; then
  HOSTNAME=$(hostname -s)
fi

echo "$HOSTNAME.$DOMAIN" > /etc/mailname
# =============================

# =============================
# Creating docker-env file
# =============================
mkdir -p /opt/iredmail
echo -e "HOSTNAME=\"$HOSTNAME\"" > /opt/iredmail/docker-env
echo -e "DOMAIN=\"$DOMAIN\"" >> /opt/iredmail/docker-env
echo -e "MYSQL_HOST=\"$MYSQL_HOST\"" >> /opt/iredmail/docker-env
echo -e "MYSQL_PORT=\"$MYSQL_HOST\"" >> /opt/iredmail/docker-env
echo -e "AMAVISD_DB_PASSWD=\"$REAL_AMAVISD_DB_PASSWD\"" >> /opt/iredmail/docker-env
echo -e "IREDADMIN_DB_PASSWD=\"$REAL_IREDADMIN_DB_PASSWD\"" >> /opt/iredmail/docker-env
echo -e "IREDAPD_DB_PASSWD=\"$REAL_IREDAPD_DB_PASSWD\"" >> /opt/iredmail/docker-env
echo -e "RCM_DB_PASSWD=\"$REAL_ROUNDCUBE_DB_PASSWD\"" >> /opt/iredmail/docker-env
echo -e "VMAIL_DB_BIND_PASSWD=\"$REAL_VMAIL_DB_PASSWD\"" >> /opt/iredmail/docker-env
echo -e "VMAIL_DB_ADMIN_PASSWD=\"$REAL_VMAIL_ADMIN_DB_PASSWD\"" >> /opt/iredmail/docker-env
chmod 600 /opt/iredmail/docker-env
# =============================

# =============================
# SSL Keys
# =============================

# Removing iRedMail generated certs
if [ -f /etc/ssl/private/iRedMail.key ]; then
  rm -f /etc/ssl/private/iRedMail.key
fi
if [ -f /etc/ssl/iRedMail.crt ]; then
  rm -f /etc/ssl/iRedMail.crt
fi

# If the user doesn't provide certs,
# we generate certs for $DOMAIN
if [ ! -d /var/vmail/ssl/ ]; then
  chmod +x /generate_ssl_keys.sh
  /generate_ssl_keys.sh $HOSTNAME.$DOMAIN

# Check if custom provided certificates exists and link to /etc/ssl
elif [[ ! -f /var/vmail/ssl/iRedMail.key || ! -f /var/vmail/ssl/iRedMail.crt ]]; then
  echo "Missing custom required certs in /var/vmail/ssl/";
  exit 1
else
  ln -s /var/vmail/ssl/iRedMail.crt /etc/ssl/certs/iRedMail.crt
  ln -s /var/vmail/ssl/iRedMail.key /etc/ssl/private/iRedMail.key
fi
# =============================

# =============================
# Service scripts permissions
# =============================
for d in $(/bin/ls /services); do
  chmod +x /services/$d/*
done
# =============================

echo
echo "========================================================================="
echo "Generating first ClamAV database..."
echo "========================================================================="
/usr/bin/freshclam 2>/dev/null

echo
echo "========================================================================="
echo "Starting services...."
echo "========================================================================="
exec /usr/bin/s6-svscan /services
