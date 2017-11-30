#!/bin/bash
# Add vmail group and user and set home directory
groupadd -g 5000 vmail
useradd -g vmail -u 5000 vmail -d /var/mail/vmail -m

# Write directory of ssl certificate and key and set
# protocol to lmtp
echo "ssl_cert = </config/ssl/ssl-cert-${SERVER_HOSTNAME}.pem
ssl_key = </config/ssl/ssl-key-${SERVER_HOSTNAME}.key
protocol lmtp {
        postmaster_address = postmaster@${SERVER_HOSTNAME}
        mail_plugins = sieve
}" > /etc/dovecot/conf.d/99-mail-stack-delivery-conf