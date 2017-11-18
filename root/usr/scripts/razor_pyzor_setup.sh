#!/bin/bash
# Create directories
mkdir /var/lib/spamassassin/.razor
mkdir /var/lib/spamassassin/.pyzor
mkdir /var/lib/spamassassin/.spamassassin

# Setup pyzor
pyzor --homedir /var/lib/spamassassin/.pyzor discover

# Setup razor
razor-admin -home=/var/lib/spamassassin/.razor -register
razor-admin -home=/var/lib/spamassassin/.razor -create
razor-admin -home=/var/lib/spamassassin/.razor -discover

# Ensure correct permissions
chown -R spamd:spamd /var/lib/spamassassin