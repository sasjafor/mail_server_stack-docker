#!/bin/bash
# Add spamd user
adduser --shell /bin/false --home /var/lib/spamassassin --disabled-password --disabled-login --gecos "" spamd

# Add spamass-milter user to spamd group
usermod -a -G spamd spamass-milter

# Create socket directory and set ownership
mkdir /var/spool/postfix/spamass
chown spamass-milter:spamd /var/spool/postfix/spamass/

# Fix permissions
chown -R spamd:spamd /var/lib/spamassassin

# Make directory for bayesian filter
mkdir /var/lib/spamassassin/.spamassassin
chown spamd:spamd /var/lib/spamassassin/.spamassassin
