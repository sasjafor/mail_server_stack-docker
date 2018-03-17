#!/bin/bash
# Set key table
echo "mail.${SERVER_HOSTNAME} mail.${SERVER_HOSTNAME}:mail:/etc/opendkim/mail" >> /etc/opendkim/KeyTable

# Set signing table
echo "*@${SERVER_HOSTNAME} mail.${SERVER_HOSTNAME}" >> /etc/opendkim/SigningTable

# Change ownership of opendkim folder
chown -R opendkim:opendkim /etc/opendkim

# Create directory for opendkim socket
mkdir /var/spool/postfix/opendkim

# Change ownership of this directory
chown opendkim:root /var/spool/postfix/opendkim

# Add postfix user to opendkim group
usermod -G opendkim postfix
