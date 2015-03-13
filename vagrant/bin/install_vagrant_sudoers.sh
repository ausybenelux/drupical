#!/bin/bash
# Add Vagrant's NFS setup commands to sudoers, for `vagrant up` without a password
# Updated to work with Vagrant 1.3.x

# Stage updated sudoers in a temporary file for syntax checking
TMP=$(mktemp -t vagrant_sudoers)
cat /etc/sudoers > $TMP
cat >> $TMP <<EOF

# Allow passwordless startup of Vagrant when using NFS.
# https://gist.github.com/joemaller/6764700

Cmnd_Alias VAGRANT_EXPORTS_ADD = /usr/bin/tee -a /etc/exports
Cmnd_Alias VAGRANT_NFSD = /sbin/nfsd restart
Cmnd_Alias VAGRANT_EXPORTS_REMOVE = /usr/bin/sed -E -e /*/ d -ibak /etc/exports
Cmdn_Alias VAGRANT_MV = /bin/mv -f /tmp/hosts /etc/hosts
Cmnd_Alias VAGRANT_HOSTMANAGER_UPDATE = /bin/cp /Users/bartarickx/.vagrant.d/tmp/hosts.local /etc/hosts%staff ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_NFSD, VAGRANT_EXPORTS_REMOVE

%admin ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_NFSD, VAGRANT_EXPORTS_REMOVE, VAGRANT_MV, VAGRANT_HOSTMANAGER_UPDATE

EOF

# Check syntax and overwrite sudoers if clean
visudo -c -f $TMP
if [ $? -eq 0 ]; then
  echo "Adding vagrant commands to sudoers"
  cat $TMP > /etc/sudoers
else
  echo "sudoers syntax wasn't valid. Aborting!"
fi

rm -f $TMP