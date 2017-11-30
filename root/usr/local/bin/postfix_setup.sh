#!/bin/bash
# Configure basic settings
postconf -e "myhostname = ${SERVER_HOSTNAME}" \
                "mydestination = $myhostname, localhost.${SERVER_HOSTNAME}, localhost" \
                "smtpd_tls_cert_file = /config/ssl/ssl-cert-${SERVER_HOSTNAME}.pem" \
                "smtpd_tls_key_file = /config/ssl/ssl-key-${SERVER_HOSTNAME}.key"

# Set postfix maps

# aliases
echo "postmaster: webmaster@${SERVER_HOSTNAME}
root: webmaster@${SERVER_HOSTNAME}
www-data: webmaster@${SERVER_HOSTNAME}" > /etc/aliases

# canonical
echo "www-data@${SERVER_HOSTNAME} mailman@${SERVER_HOSTNAME}" > /etc/postfix/canonical

# Hash the maps
newaliases
postmap /etc/postfix/canonical