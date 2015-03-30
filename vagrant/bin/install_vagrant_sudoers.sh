#!/bin/bash

TMP=$(mktemp -t vagrant_sudoers)

cat /etc/sudoers > $TMP

cat >> $TMP <<EOF

Cmnd_Alias VAGRANT_EXPORTS_ADD = /usr/bin/tee -a /etc/exports
Cmnd_Alias VAGRANT_NFSD = /sbin/nfsd restart
Cmnd_Alias VAGRANT_EXPORTS_REMOVE = /usr/bin/sed -E -e /*/ d -ibak /etc/exports

Cmdn_Alias VAGRANT_MV_HOSTS = /bin/mv -f /tmp/hosts /etc/hosts
Cmnd_Alias VAGRANT_HOSTMANAGER_UPDATE = /bin/cp /Users/bartarickx/.vagrant.d/tmp/hosts.local /etc/hosts

%staff ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_NFSD, VAGRANT_EXPORTS_REMOVE, VAGRANT_MV_HOSTS, VAGRANT_HOSTMANAGER_UPDATE
%admin ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_NFSD, VAGRANT_EXPORTS_REMOVE, VAGRANT_MV_HOSTS, VAGRANT_HOSTMANAGER_UPDATE

EOF

visudo -c -f $TMP

if [ $? -eq 0 ]; then
  echo "Adding vagrant commands to sudoers"
  cat $TMP > /etc/sudoers
else
  echo "sudoers syntax wasn't valid. Aborting!"
fi

rm -f $TMP