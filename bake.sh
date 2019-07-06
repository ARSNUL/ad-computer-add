#!/usr/bin/env bash


# password specified on cmd line?
# prompt for password?
echo "Please supply password for administrator@corp.helm.ai"
read -s ADMINPASS
echo "ADMINPASS is '${ADMINPASS}'"
echo "Please supply fully capitalized FQDN (CORP.EXAMPLE.COM)"
read FQDN
echo "Please supply fully capitalized Kerberos realm (EXAMPLECOM)"
read SHORTNAME
exit


export DEBIAN_FRONTEND=noninteractive

sudo apt update
sudo apt -yq install krb5-user samba sssd chrony
exit
# apply replacement values
#./mix.sh

# patch /etc/krb5.conf
# patch /etc/samba/smb.conf
# patch /etc/pam.d/common-session
cp sssd.conf /etc/sssd/
chown root:root /etc/sssd/sssd.conf
chmod 600 /etc/sssd/sssd.conf
systemctl restart smbd.service nmbd.service chrony.service
kinit Administrator ${PASS}
systemctl restart smbd.service nmbd.service chrony.service sssd.service


