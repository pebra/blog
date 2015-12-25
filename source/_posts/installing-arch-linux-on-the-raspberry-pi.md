---
layout: post
title: "Installing Arch Linux on the Raspberry Pi"
date: 2014-02-16 11:22
comments: true
tags:
- linux
- rapsberry
- pi
- arch linux
---

[{% img center /static/images/pisd.JPG %}]({{root_url}}/images/pisd.JPG)


### Choosing the image
There are many use cases for the Pi and therefore you will find a lot of images, that will try to match your needs. Since I just want to run some server applications on the Pi, that need no GUI at all, I will go for the Arch Linux image. There are surely enough other images that will fit the needs as well or even better, feel free to try them out, the installation steps should be the same.
You can find the Arch and many other images on the [download site](http://www.raspberrypi.org/downloads) at [raspberrypi.org](http://raspberrypi.org)

### Download the image and prepare the SD card

Depending on your operating system, there are different ways to set up the SD card, so it will boot your Linux distribution of choice.
I will try to cover both Linux and OSX by sticking to the command line, since they have many commands in common.(differences will be marked)

First download and extract the image:

``` bash
curl -o arch_arm.img.zip -L http://downloads.raspberrypi.org/arch_latest
# if your system is missing curl, install it via your systems package manager
# some examples
# on ubuntu: apt-get install curl
# on mac with brew: brew install curl
```

After downloading is finished, check the integrity of the image. This can save you a lot of pain!
A corrupted download will make you to have to repeat the whole setup again.
Generate the checksum of your download and compare it to the checksum on the [downloads page](http://www.raspberrypi.org/downloads).

``` bash
# generating the checksum of the downloaded file
shasum arch_arm.img.zip
# the command could be named sha1sum for some folks
```
If the checksums are matching, lets extract the zip file.

``` bash
unzip arch_arm.img.zip
```
Note that the extracted file will be named something like ArchLinuxArm-some-release-date-rpi.img.

Put in the SD card format it with your tool of choice to FAT32 and remove it.

Then do

``` bash
df -h
```
[{% img center /static/images/df_before.png %}]({{root_url}}/images/df_before.png)

Now insert the SD card.
Again run

``` bash
df -h
```
[{% img center /static/images/df_after.png %}]({{root_url}}/images/df_after.png)
The additional device listed is your SD card.
In my case it's */dev/disk2*, this will differ from machine to machine. So if I use /dev/disk2 in some following commmands just see it as a placeholder for your device name.

The next step will differ a little whether you are using an OSX or a Linux OS.
The SD card needs to be unmounted now.

``` bash
# only for mac users
sudo diskutil unmountDisk /dev/disk2
```
On Linux it should look something like this:

``` bash
# only do this when you are on a linux machine
umount /dev/disk2
```

### Flashing the image

Alright, now it's time to flash the image to the disk.
This step will again slightly differ from OSX to Linux.

``` bash
# on a mac machine the m for bs=1m is written in lower case.
# using rdisk2 over disk2 will give you a nice speed boost in many cases but it's mac only
sudo dd bs=1m if=ArchLinuxARM-2014.01-rpi.img of=/dev/rdisk2
```

``` bash
# on linux machines the M is written in upper case an the bs is set to 4
dd bs=4M if=/path/to/your/image.img of=/dev/disk2
```

Ok, since the image is not that big, flashing will be quite fast.
As the final step eject the SD card.

``` bash
# mac
sudo diskutil eject /dev/rdisk2
```
On Linux, clear the write cache, to safely remove the card.

``` bash
# linux
sudo sync
```

Now the moment of truth has come. Pull your SD card out of your computer an put it in your Pi!
**Notice:** put the SD card in **before** plugging in the power supply.

Login will be root, root. Change this immediately:

``` bash
# after logging in to the Pi run
passwd
```
Now the Pi should be up and running, awesome!
