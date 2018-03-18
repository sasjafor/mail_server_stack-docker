#!/bin/bash
# Add spamd user
adduser --shell /bin/false --home /var/lib/spamassassin --disabled-password --disabled-login --gecos "" spamd

# Add spamass-milter user to spamd group
usermod -a -G spamd spamass-milter

# Create socket directory and set ownership
mkdir /var/spool/postfix/spamassassin
chown spamd:root /var/spool/postfix/spamassassin/

# Make directory for bayesian filter & fix permissions
mkdir /var/lib/spamassassin/.spamassassin
chown -R spamd:spamd /var/lib/spamassassin
