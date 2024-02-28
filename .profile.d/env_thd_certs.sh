# vim: set ft=shellscript
if [ -f "/usr/local/munki/thd_certs.pem" ]; then
    export NODE_EXTRA_CA_CERTS="/usr/local/munki/thd_certs.pem"
fi
