#!/bin/bash
# Create socket directory and set ownership
mkdir /var/spool/postfix/clamav
chown clamav:root /var/spool/postfix/clamav/