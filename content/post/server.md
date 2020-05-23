---
title: "Server"
date: 2019-10-05T14:31:39+01:00
draft: true
---

# Self-hosted @ Interwubs

## Core Structure

- container orchestration: docker-compose
- tempdns: duckdns
- SSL reverse proxy: traefik
- storage backups: rsnapshot + rsync to home server?
- usermanagement: ldap
- monitoring: prometheus

### Setup Process



## Services

- LDAP management: Nextcloud/phpldapadmin?
- Files: Nextcloud
- Contacts and Calendar: Nextcloud
- VPN: OpenVPN on 443
- eBook Library: calibre-web
- Audiobooks: Funkwhale
- Foto Backups: PhotoBackup/Nextcloud?
- Objectstorage: minio
- RSS feed: miniflux
- notes/wiki: meemo

# Self-hosted @ Home

## ToDo:

- move data out of nextcloud
- docker-compose push to gitlab
- backup repo key to LastPass
- remove music services, unneeded minio, nextcloud, piwigo

## Core Structure

- SSD for /
- 1.5 TB 2.5 for data
- RAID0 750GBx2 for backups (rsync from data)
- monitoring: prometheus
- Mail notifications: postfix or does mailbox block these?
- UserAuth: ldapcache of rknt?
- Tunnel to rknt for remote access from rknt vpn?

## Services

- Fileserver: NFS, AFP?
- Backupserver
  - Linux Laptops: minio?
  - rknt Server: rsync via ssh with pwless root
- Gallery: PhotoPrism?

## Setup

### rknt backups with pw-less rsync

See [this tutorial](https://www.guyrutenberg.com/2014/01/14/restricting-ssh-access-to-rsync/) on restricted root rsync access.

- `ssh-keygen` a pw-less key for root, scp to remote server
- allow root login in `/etc/sshd_config` (it will be limited to rrsync)
- add key to `/root/.ssh/authorized_keys` but limit its use to rrsync:
  `command="$HOME/bin/rrsync -ro ~/backups/",no-agent-forwarding,no-port-forwarding,no-pty,no-user-rc,no-X11-forwarding ssh-rsa AAA...vp Automated remote backup`
- unzip and make executable the rrsync script found in:
  `/usr/share/doc/rsync/scripts/rrsync.gz`
- sync files
  `sudo rsync -e "ssh -i /root/.ssh/id_rsa" -az --info=progress2 --delete root@rknt.de: /srv/data/rknt_home_mirror/`
 - Note: source of rsync is always relative to the folder specified in the `command=` in the `authorized_keys`

### AFP Fileserver

Mostly follow [this guide](https://catelin.net/2018/03/10/turn-your-linux-box-into-an-afp-server/).
But use the configure flags from [this Dockerfile](https://github.com/cptactionhank/docker-netatalk/blob/master/Dockerfile):

"""
./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --with-init-style=debian-systemd \
        --without-libevent \
        --without-tdb \
        --with-cracklib \
        --enable-krbV-uam \
        --with-pam-confdir=/etc/pam.d \
        --with-dbus-sysconf-dir=/etc/dbus-1/system.d \
        --with-tracker-pkgconfig-version=2.0 \
"""

Note: I changed the tracker pgkconfig version to 2.0 as the Dockerfile is using jessie and we are on a newer version of Debian/Ubuntu.

### ZFS

"""
sudo apt install zfs-auto-snapshot zfsutils-linux
"""