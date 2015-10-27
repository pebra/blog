---
layout: post
title: "Setting up Seafile server on the Raspberry Pi"
date: 2014-02-17 15:34
comments: true
published: false
tags:
---

Now that the Pi is up and running we can finally put some stuff on it.
Lets start with [Seafile](http://http://seafile.com/) which advertises itself as {% blockquote %} Next-generation Open Source Cloud Storage with advanced features on file syncing, privacy protection and teamwork!{% endblockquote %}
Awesome, as long as I won't have to collaborate with the NSA I'm fine with that =)

First, lets install the system requirements for seafile

``` bash
# pacman is arch linux' package manager
pacman -Ssy # update pacman's sources
pacman -S python2 python2-imaging python2-simplejson python2-setuptools git glibc make
```

Fortunately the folks from seafile provide a version of their software especially for the Pi.
Downloading it with curl

``` bash
curl -OL http://seafile.googlecode.com/files/seafile-server_2.1.3_pi.tar.gz
```
Extract the archive

``` bash
tar xfz seafile-server_2.1.3_pi.tar.gz
```
The guides on seafile's github wiki suggest the following layout

``` bash
pebra-box/
  |-- installed
  |   `-- seafile-server_2.1.3_pi.tar.gz
  `-- seafile-server-2.1.3
      |-- reset-admin.sh
      |-- runtime
      |-- seaf-fuse.sh
      |-- seafile
      |-- seafile.sh
      |-- seahub
      |-- seahub.sh
      |-- setup-seafile-mysql.py
      |-- setup-seafile-mysql.sh
      |-- setup-seafile.sh
      `-- upgrade
```

After downloading and extracting, we have to run the setup script

``` bash
./setup-seafile.sh
```


curl -OL https://aur.archlinux.org/packages/li/libsepol/libsepol.tar.gz
cd libsepol
makepkg
sudo pacman -U libsepol-2.2-2-armv6h.pkg.tar.xz

curl -OL https://aur.archlinux.org/packages/li/libselinux/libselinux.tar.gz
