#!/usr/bin/env bash


echo "Please supply fully capitalized FQDN (CORP.EXAMPLE.COM)"
read FQDN
echo "Please supply fully capitalized Kerberos realm (EXAMPLECOM)"
read SHORTNAME
echo "Please supply password for administrator@${FQDN}"
read -s ADMINPASS
#echo "ADMINPASS is '${ADMINPASS}'"


export DEBIAN_FRONTEND=noninteractive
apt update
apt -yq install krb5-user samba sssd chrony


# sed apply replacement values
sed -i "s/__SEDFQDNCAP__/${FQDN}/g" krb5.conf.patch
sed -i "s/__SEDFQDNCAP__/${FQDN}/g" smb.conf.patch
sed -i "s/__SEDWORKGROUPNAMECAP__/${SHORTNAME}/g" smb.conf.patch
sed -i "s/__SEDFQDNCAP__/${FQDN}/g" sssd.conf


# apply patches
patch /etc/krb5.conf krb5.conf.patch
patch /etc/samba/smb.conf smb.conf.patch
patch /etc/pam.d/common-session common-session.patch


cp sssd.conf /etc/sssd/
chown root:root /etc/sssd/sssd.conf
chmod 600 /etc/sssd/sssd.conf


systemctl restart smbd.service nmbd.service chrony.service


echo "${ADMINPASS}" | kinit Administrator
klist
net ads join -k


systemctl restart smbd.service nmbd.service chrony.service sssd.service


getent passwd ekeyser

