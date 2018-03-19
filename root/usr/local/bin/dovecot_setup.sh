#!/bin/bash
# Add vmail group and user and set home directory
groupadd -g 5000 vmail
useradd -g vmail -u 5000 vmail -d /var/mail/vmail -m

# Fix permissions
chown -R vmail:vmail /var/mail/

# Write directory of ssl certificate and key and set
# protocol to lmtp
echo "ssl_cert = </config/ssl/ssl-cert-${SERVER_HOSTNAME}.pem
ssl_key = </config/ssl/ssl-key-${SERVER_HOSTNAME}.key
protocol lmtp {
        postmaster_address = postmaster@${SERVER_HOSTNAME}
        mail_plugins = sieve
}" >> /etc/dovecot/conf.d/99-mail-stack-delivery.conf

# Write connection string to sql conf file
echo "connect = host=localhost dbname=mailserver user=mailuser password=${POSTGRES_PASSWORD}" >> /etc/dovecot/conf.d/dovecot-sql.conf.ext
