---
layout: post
title: "Keep your data at home"
date: 2014-02-07 16:00
comments: true
tags:
- raspberry pi
- arch linux
- privacy
---

While services like Dropbox or Box.com are great for collaborative work and stuff, I always feel kind of afraid putting more personal data in there.
But I want to satisfy my desire to keep important files and media with me, while keeping them in sync with my devices.
I want to have my own dropbox, serving my files from home.

So I started with buying a [Raspberry Pi(Model B)](http://raspberrypi.org) and throwing Owncloud on it.
While installation and setup worked quite fluently, the performance was a desaster. A simple request to the webinterface of Owncloud on my Pi took about 20 seconds, which brings me to the conclusion, that Owncloud will be no fit for the Pi and it's capabilities.

Fortunately there is a [ alternative to Owncloud ]( http://seafile.com ) which looks promising plus it's open source and free for personal use.
It has a free app for Android as well, therefore I will give it a shot.

My next blog posts will be about setting up useful server applications on the Pi such as

  + [Seafile]( http://seafile.com ) - private Owncloud-like file sync
  + [Mumble]( http://mumble.sourceforge.net/ ) - encrypted, low-latency voice chat
  + maybe [Jabber]( http://jabber.org ) - XMPP


I will also cover and start with:

  + Installing [openwrt](http://openwrt.org) on my [WD N600 Router](http://wiki.openwrt.org/toh/wd/n600) (to setup DDNS with [no-ip.org](https://no-ip.org))
  + Installing [arch linux](http://archlinuxarm.org/) on the Pi

**Disclaimer:** I have no clue if the PI can handle the stuff I am going to install =)
