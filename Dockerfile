FROM ubuntu

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
			zoo \
			iptables-persistent && \
	rm -rf /var/lib/apt/lists/*

# Copy source
COPY root/ /

VOLUME /config /var/mail/vmail

EXPOSE 25 465 587 110 995 143 993

CMD ["/run.sh"]