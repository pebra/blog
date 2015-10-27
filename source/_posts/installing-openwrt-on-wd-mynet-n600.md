---
layout: post
title: "Installing OpenWrt on WD MyNet N600"
date: 2014-02-07 12:00
published: true
comments: true
tags: n600 openwrt western digital
---

In order to access the PI from outside my local network I need to keep track of my home's IP address. Since I have no static IP at home I'll have to deal with DDNS.
<!-- (Please let me know if there are other solutions, maybe self hosted?) -->
[{% img center /static/images/n600.jpg %}]({{root_url}}/images/n600.jpg)

I researched some dynamic DNS providers and was surprised to find, that only a few free solutions were left.
In the past I was very happy with [dnydns.org](http://dyndns.org), but they stopped their free plans.
Fortunately there is [no-ip.org](http://no-ip.org), which is keeping up with free plans for single users.

Sadly, the stock firmware which ships with my N600 only supports tzo and dyndns.org as providers for dynDNS which are not quite the same company I guess.
So no satisfying solution here.
Which forces me install some cool stuff on my router: [OpenWrt](http://openwrt.org)

According to their website, installation should be straight forward:

``` bash
1) Download the file openwrt-ar71xx-generic-mynet-n600-squashfs-sysupgrade.bin
2) Configure your computers IP address to 192.168.1.10 and connect to a LAN port in the router.
3) Turn the router off.
4) Using a paperclip, press and hold the reset button on the bottom of the router and turn it on. Hold the reset button for at least 15 seconds.
5) On your computer, visit http://192.168.1.1 NOTE: You will not be able to ping this address.
6) Upload the file openwrt-ar71xx-generic-mynet-n600-squashfs-sysupgrade.bin as downloaded earlier.
7) The router will now flash OpenWRT. This will take a couple of minutes to achieve. You can ping 192.168.1.1 and watch for ping replies to see when your router has rebooted into OpenWRT
```

Alright step 1 is easy. Step 2 can be tricky if you are using some linux-ish OS.
I did it on Mint with editing /etc/network/interfaces and adding following lines:

``` bash
# /etc/network/interfaces
iface eth0 inet static
  address 192.168.1.10
  netmask 255.255.255.0
  gateway 192.168.1.1
```

Did a

``` bash
sudo /etc/init.d/networking restart
```
after saving the file.

This enables me to connect my machine and the router directly via LAN.
Step 3 to 7 worked flawlessly.
After flashing OpenWrt ist done, you can telnet on the router.

``` bash
telnet 192.168.1.1
```

Not lets install a web interface called LuCI.
Fortunately there are great [step-by-step instructions](http://wiki.openwrt.org/doc/howto/luci.essentials) already there!

``` bash
opkg update
opkg install luci
opkg install luci-ssl
# Start the web server (uHTTPd)
/etc/init.d/uhttpd start
# Enable the web server (uHTTPd)
/etc/init.d/uhttpd enable
```

It just works, great.


Now we need DDNS support, since it is not avaiable out-of-the-box by luci.

``` bash
opkg install luci-app-ddns
opkg install ddns-scripts
```

The DDNS service was disabled by default, so I turned it on via System -> Startup

[{% img center /static/images/ddns-disabled.png %}]({{root_url}}/images/ddns-disabled.png)

Now after refreshing the page there should be a new tab called "Services" at the web interface's navigation.
You can choose a ton of providers here. As mentioned, I will go ahead with no-ip.org.

[{% img center /static/images/ddnsworking.png %}]({{root_url}}/images/ddnsworking.png)

After setting up the PI we will need these prerequisites to use our applications from outside our local network, e.g. with the smartphone.

But this should be it for now.

Please do not forget to set up a root password and all the other stuff like ssh and the wifi(if needed).
