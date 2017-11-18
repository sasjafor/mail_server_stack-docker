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

# domains
echo "${SERVER_HOSTNAME}      OK" > /etc/postfix/virtual-mailbox-domains

# virtual mailbox users
echo "sascha@${SERVER_HOSTNAME}		sascha@${SERVER_HOSTNAME}
mailman@${SERVER_HOSTNAME}	mailman@${SERVER_HOSTNAME}
webmaster@${SERVER_HOSTNAME}	webmaster@${SERVER_HOSTNAME}" > /etc/postfix/virtual-mailbox-users

# virtual
echo "sascha@${SERVER_HOSTNAME}		sascha@${SERVER_HOSTNAME}
mailman@${SERVER_HOSTNAME}	mailman@${SERVER_HOSTNAME}
webmaster@${SERVER_HOSTNAME}	webmaster@${SERVER_HOSTNAME}
postmaster@${SERVER_HOSTNAME}	webmaster@${SERVER_HOSTNAME}
root@mail.${SERVER_HOSTNAME}	webmaster@${SERVER_HOSTNAME}
root@${SERVER_HOSTNAME}		webmaster@${SERVER_HOSTNAME}
abuse@${SERVER_HOSTNAME}	webmaster@${SERVER_HOSTNAME}
hostmaster@${SERVER_HOSTNAME}	webmaster@${SERVER_HOSTNAME}" > /etc/postfix/virtual

# Hash the maps
newaliases
postmap /etc/postfix/canonical
postmap /etc/postfix/virtual-mailbox-domains
postmap /etc/postfix/virtual-mailbox-users
postmap /etc/postfix/virtual