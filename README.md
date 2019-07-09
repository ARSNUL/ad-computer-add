# ad-add-computer
## Add a Ubuntu/Debian computer to an Active Directory domain in a semi-automated fashion

`sudo ./bake.sh`

You will be prompted for a fully qualified domain name (example.com) and a short form name typical of Windows Workgroup or Netbios-like naming conventions (EXAMPLECOM), and finally a password for `administrator@`.

This script generally follows this guide: [SSSD and Active Directory](https://help.ubuntu.com/lts/serverguide/sssd-ad.html)