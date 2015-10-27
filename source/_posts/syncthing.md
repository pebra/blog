title: Setting up Syncthing on Raspberry PI 2 as "always ON" device
date: 2015-08-23 20:49:20
tags: syncthing, raspberry, pi, android
---

[{% img center /static/images/logo-horizontal.svg %}]({{root_url}}static/images/logo-horizontal.svg)

Yeah, uhm, I think I still [owe you a post](/2014/02/07/keep-your-data-at-home/) for some dropbox'ish thing to sync files over multiple devices.
At first I was willing to give [seafile](http://seafile.com) a try, but after reading [this](https://github.com/haiwen/seafile/issues/587) it became a nono for me.

Fortunately there is [Syncthing](http://syncthing.net) - a peer to peer based syncing solution that runs on almost any platform.
Another plus: there is an [android app](https://github.com/syncthing/syncthing-android) and a third party iOS app seems to be in development, awesome!

There is already an impressive number of tutorials for installation and setup out there and the [syncthing documentation](http://docs.syncthing.net/) is great. Therefore I'll only cover the very specific things to my setup.

## Setting up the "Server"

Syncthing is no client-server application.
Files will only sync if at least two devices are running and online. To make syncthing a Dropbox alternative I have one device that is online all the time. It always knows the most recent state of my files.
We will use a Raspberry PI 2 running Arch Linux as our *always online* device.
Consider the following commands to be executed on the PI.

#### Step 1: Get the Syncthing Package

    # Version might have changed when you are reading this.
    curl -OL https://github.com/syncthing/syncthing/releases/download/v0.11.21/syncthing-linux-arm-v0.11.21.tar.gz

#### Step 2: Unpack the Package

    mkdir syncthing
    tar xfvz syncthing-linux-arm-v0.11.21.tar.gz -C syncthing --strip-components=1

Nice, Syncthing is now unpacked in a folder called syncthing.

#### Step 3: Make the Web Interface accessible in your local network

Syncthing brings a nice web GUI that lets you configure your peer. By default it is only accessible from the peer running syncthing.
Since I don't have desktop environment installedon the PI, I want to access the web GUI from my laptop.
In order to get this working we have to tweak the syncthing config a bit.

First, run syncthing once so it creates all the default folders.

    cd syncthing/
    ./syncthing
    # hit CTRL + C after everything booted up.

Now edit the syncthing config with your favorite editor.

    vim ~/.config/syncthing/config.xml

Change this line

    <gui enabled="true" tls="false">
        <address>127.0.0.1:8384</address>
    </gui>

to this

    <gui enabled="true" tls="false">
        <address>0.0.0.0:8384</address>
    </gui>

We can now access the web GUI of the PI via http://IP_ADDRESS_OF_YOUR_PI:8384


#### Step 4: Run Syncthing on Startup

You may not want to start Syncthing by hand everytime you restart your Raspberry, the guys from Syncthing got your back.

    # do the next stuff as root
    su
    cd syncthing # if your aren't already there
    cp syncthing /usr/bin/
    chmod a+x /usr/bin/syncthing

    cp etc/linux-systemd/user/syncthing.service /usr/lib/systemd/user/
    systemctl --user enable syncthing.service

    reboot

Syncthing now starts at every boot!

I had some troubles figuring out how to do this proerly so I thought it would be worth mentioning.


## Other Devices

If you are running Arch Linux on your machine it is as easy as this

    pacman -S syncthing
    systemctl --user enable syncthing.service
    systemctl --user start syncthing.service

## Setup your to be synced Folders and such

Please see the [documentation](http://docs.syncthing.net/intro/getting-started.html) for all the configuration web GUI stuff, it's very comprehensive.

## Conclusion

I am really satisfied with this solution as my Dropbox alternative, everything seems to work well and I hope my
few notes on setting it up on the Raspberry PI will save you some time while setting up your own Syncthing!

