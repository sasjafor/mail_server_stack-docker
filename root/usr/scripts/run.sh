#!/bin/bash
if [$SERVER_INIT == 0]
then
# Configure postfix
./usr/scripts/postfix_setup.sh

# Configure dovecot
./usr/scripts/dovecot_setup.sh

# Configure opendkim
./usr/scripts/opendkim_setup.sh

# Configure spamass
./usr/scripts/spamass_setup.sh

# Configure razor & pyzor
./usr/scripts/razor_pyzor_setup.sh

# Configure clamav
./usr/scripts/clamav_setup.sh

# Configure sieve
./usr/scripts/sieve_setup.sh

# Configure iptables
iptables-restore rules.v4

# Configure php
./usr/php_setup.sh

export SERVER_INIT=1
fi