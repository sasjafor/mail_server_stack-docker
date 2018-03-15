#!/usr/bin/env bash
set -e
# Configure postfix
./usr/local/bin/postfix_setup.sh
echo "=== POSTFIX CONFIGURED ==="

# Configure dovecot
./usr/local/bin/dovecot_setup.sh
echo "=== DOVECOT CONFIGURED ==="

# Configure opendkim
./usr/local/bin/opendkim_setup.sh
echo "=== OPENDKIM CONFIGURED ==="

# Configure spamass
./usr/local/bin/spamass_setup.sh
echo "=== SPAMASS CONFIGURED ==="

# Configure razor & pyzor
./usr/local/bin/razor_pyzor_setup.sh
echo "=== RAZOR AND PYZOR CONFIGURED ==="

# Configure clamav
./usr/local/bin/clamav_setup.sh
echo "=== CLAMAV CONFIGURED ==="

# Configure sieve
./usr/local/bin/sieve_setup.sh
echo "=== SIEVE CONFIGURED ==="

# Configure iptables
#iptables-restore /etc/iptables/rules.v4

# Start services
#service postfix start
#echo "=== POSTFIX STARTED ==="
#service dovecot start
#echo "=== DOVECOT STARTED ==="
#service opendkim start
#echo "=== OPENDKIM STARTED ==="
#service clamav-milter start
#echo "=== CLAMAV STARTED ==="
#service spamass-milter start
#echo "=== SPAMASS STARTED ==="

exec "$@"
