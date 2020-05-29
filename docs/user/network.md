---
title: Network Configuration
---

This section covers the network configuration of the FruitNanny which is one
of the more complicated topics.


## Connect to Home WLAN

The accessing device only needs to be in the same local network as the
FruitNanny in order to use the web UI. This meas if the FruitNanny is later
connected to the local home WLAN, the web UI can accessed from any device in
the home network.

1. Select *Network* via the app main menu in the top left corner.
2. Go to the *WLAN* tab and select the network of choice.
3. You will be prompted for the password.
4. Connect your device to the **same WLAN** and go back to your browser within
   **60 seconds**. Wait for the connection to be established.

!!! note
	FruitNanny implements a safety mechanism to avoid you locking yourself out of
	your FruitNanny when changing network settings. A checkpoint is created
	before any change in network configuration is performed. This checkpoint will
	automatically rollback any change after 60 seconds. This means, if you have
	messed up the your configuration, do not worry, your FruitNanny will be back
	after one minute.

	The web UI will try to clear the checkpoint. This is only successful if your
	device is able to connect to the FruitNanny after the network settings were
	changed.


## SSH Access <small>– :material-atom: Advanced</small>

The FruitNanny can be access via SSH with the standard Raspberry Pi method as
user `pi`. It is recommended to use *public key authentication* instead of
passwords.

User `pi` has password-less `sudo` access. It is important to **run no
service** as user `pi`.

```bash
# Connect to FruitNanny
ssh pi@fruitnanny.local
```


## Using IP Addresses

If for some reason mDNS does not work in your network or on your device which
means your device is not able to resolve `fruitnanny.local`, this section
describes how to use IP address to connect to the FruitNanny.

Most of the time, your network router will assign an dynamic IP address to the
FruitNanny. This means, the address can change over time. The dynamic address
can be determined via DNS service discovery (DNS-SD). This is a list example
apps for different mobile platforms:

 - Android: [Service Browser](https://play.google.com/store/apps/details?id=com.druk.servicebrowser)
 - iOS: [Discovery - DNS-SD Browser](https://apps.apple.com/us/app/discovery-dns-sd-browser/id305441017)

Browse the *.local* domain for *_http._tcp* services. The FruitNanny should be
available as *FruitNanny Web UI*.
