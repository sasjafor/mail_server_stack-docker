FROM ubuntu:bionic

# Install packages
RUN echo "postfix postfix/mailname string local.loc" | debconf-set-selections && \
	echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections && \
	echo "iptables-persistent iptables-persistent/autosave_v4 boolean true" | debconf-set-selections && \
	echo "iptables-persistent iptables-persistent/autosave_v6 boolean true" | debconf-set-selections && \
	apt update && \
	apt install -y --no-install-recommends \
			mail-stack-delivery \
			dovecot-lmtpd \
			dovecot-pgsql \
			postfix-pgsql \
			opendkim \
			opendkim-tools \
			spamass-milter \
			pyzor \
			razor \
			libmail-dkim-perl \
			clamav-milter \
			arj \
			bcrypt \
			bzip2 \
			cabextract \
			cpio \
			file \
			gzip \
			lhasa \
			lzop \
			nomarch \
			p7zip \
			pax \
			rar \
			rpm \
			unrar \
			unzip \
			zip \
#			zoo \
			iptables-persistent && \
	rm -rf /var/lib/apt/lists/*

VOLUME /config /var/mail/vmail

# Copy source
COPY root/ /

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 25 465 587 110 995 143 993

COPY init.sh /usr/local/bin/

CMD ["/usr/local/bin/init.sh"]

RUN 	apt update && \
	apt install -y --no-install-recommends \
			syslog-ng && \
	rm -rf /var/lib/apt/lists/*
