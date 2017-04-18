#!/bin/sh
if [ $# -ne 4 ]; then
	echo "Usage: username domain NTLMv2hash upstream_proxy"
        exit 1
fi
echo UserName $1 >> /etc/cntlm.ini
echo Domain $2 >> /etc/cntlm.ini
echo PassNTLMv2 $3 >> /etc/cntlm.ini
echo Proxy $4 >> /etc/cntlm.ini
echo NoProxy localhost, 127.0.0.*, 10.*, 192.168.*, *.$2 >> /etc/cntlm.ini
echo Gateway yes >> /etc/cntlm.ini
# This denies all ip addresses outright
echo Deny 0/0 >> /etc/cntlm.ini
# This allows a specific ip address or range of addresses
# For multiple "Allow"s, add them each one on a new line
echo Allow 172.17.0.0/24
echo Listen 3128 >> /etc/cntlm.ini

exec /usr/sbin/cntlm -f -U cntlm -c /etc/cntlm.ini
