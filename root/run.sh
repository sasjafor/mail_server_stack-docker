#!/bin/bash
# Configure postfix
./usr/local/bin/postfix_setup.sh

# Configure dovecot
./usr/local/bin/dovecot_setup.sh

# Configure opendkim
./usr/local/bin/opendkim_setup.sh

# Configure spamass
./usr/local/bin/spamass_setup.sh

# Configure razor & pyzor
./usr/local/bin/razor_pyzor_setup.sh

# Configure clamav
./usr/local/bin/clamav_setup.sh

# Configure sieve
./usr/local/bin/sieve_setup.sh

# Configure iptables
iptables-restore /etc/iptables/rules.v4

# Start services
service postfix start
service dovecot start