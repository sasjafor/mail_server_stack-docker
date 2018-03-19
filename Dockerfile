FROM ubuntu:bionic

RUN 	apt update && \
		apt upgrade -y --no-install-recommends && \
		apt install -y --no-install-recommends \
			curl \
			ca-certificates

RUN	update-ca-certificates

RUN		curl https://repo.dovecot.org/DOVECOT-REPO-GPG | gpg --import && \
		gpg --export ED409DA1 > /etc/apt/trusted.gpg.d/dovecot.gpg && \
		echo "deb https://repo.dovecot.org/ce-2.3-latest/ubuntu/xenial xenial main" > /etc/apt/sources.list.d/dovecot.list

# Install packages
RUN 	echo "postfix postfix/mailname string local.loc" | debconf-set-selections && \
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
			spamassassin \
			pyzor \
			razor \
			libmail-dkim-perl \
			clamav-milter \
			clamav-daemon \
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
			iptables-persistent

RUN 	apt install -y --no-install-recommends syslog-ng

RUN		apt purge -y --no-install-recommends curl && \
		apt autoremove -y && \
		rm -rf /var/lib/apt/lists/*

VOLUME /config /var/mail/vmail

# Copy source
COPY root/ /

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 25 465 587 110 995 143 993

COPY init.sh /usr/local/bin/

CMD ["/usr/local/bin/init.sh"]
