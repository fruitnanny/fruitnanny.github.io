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


## Using IP Addresses

!!! todo
	This section will describe how to use the FruitNanny in case mDNS is not
	available.
