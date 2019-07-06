#!/usr/bin/env bash


# password specified on cmd line?
# prompt for password?
PASS=$1
export DEBIAN_FRONTEND=noninteractive

sudo apt update
sudo apt -yq install krb5-user samba sssd chrony

# apply replacement values
./mix.sh

# patch /etc/krb5.conf
# patch /etc/samba/smb.conf
# patch /etc/pam.d/common-session
sudo cp sssd.conf /etc/sssd/
sudo chown root:root /etc/sssd/sssd.conf
sudo chmod 600 /etc/sssd/sssd.conf
sudo systemctl restart smbd.service nmbd.service chrony.service
sudo kinit Administrator ${PASS}
sudo systemctl restart smbd.service nmbd.service chrony.service sssd.service


