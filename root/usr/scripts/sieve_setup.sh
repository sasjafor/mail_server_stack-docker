#!/bin/bash
# Create sieve folders
mkdir /var/mail/vmail/sieve-before
mkdir /var/mail/vmail/sieve-after
chown -R vmail:vmail /var/mail/vmail/sieve-before
chown -R vmail:vmail /var/mail/vmail/sieve-after

# Run sievec
sievec /var/mail/vmail/sieve-before/masterfilter.sieve
chown vmail:vmail /var/mail/vmail/sieve-before/masterfilter.svbin