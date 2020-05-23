# Rasberry Pi Setup


This section describes the software setup of Raspberry Pi. The model used for
here is a [Raspberry Pi 3+][RPi-3B+].

<img alt="Raspbian Logo" src="https://upload.wikimedia.org/wikipedia/de/c/cb/Raspberry_Pi_Logo.svg" style="max-width: 100px; margin: 0 auto; display: block;">

---

## Flash the Raspbian

We use [Raspban Buster Lite](https://www.raspberrypi.org/downloads/raspbian/)
as base version.

```bash
# Download latest zipped Raspbian image. This downloads a
# "YYYY-MM-DD-raspbian-buster-lite.zip" file.
curl -O $(curl --head -sL -w %{url_effective} -o /dev/null https://downloads.raspberrypi.org/raspbian_lite_latest)

# Download the SHA256 checksum
curl -O $(curl --head -sL -w %{url_effective} -o /dev/null https://downloads.raspberrypi.org/raspbian_lite_latest).sha256

# Verify the download
sha256sum -c *-raspbian-buster-lite.zip.sha256

# Unpack zipped image file
unzip *-raspbian-buster-lite.zip

# Clean up zip and checksum file
rm -v *-raspbian-buster-lite.zip *-raspbian-buster-lite.zip.sha256
```

Now, insert the SD card and determine the device path. In our example this is
`/dev/mmcblk0`.

!!! note
	It is the SD device `/dev/mmcblk0`, not a partition on the device,
	e.g. `/dev/mmcblk0p1`.

!!! warning
	Double check the device path. The following operation will destroy any
	data on the output device.

```bash
# Write Raspbian image to SD card
sudo dd if=$(ls *-raspbian-buster-lite.img) of=/dev/mmcblk0 bs=4M status=progress

# Reload partition table of the SD card
sudo partprobe /dev/mmcblk0
```


## Enable SSH

SSH is enabled by placing a file named `ssh` into the root directory of the
boot partition.

```bash
# Mount boot partition
sudo mount /dev/mmcblk0p1 /mnt/

# Create "ssh" file to enable SSH server
sudo touch /mnt/ssh

# Unmount boot partition again
sudo umount /mnt
```

The SD card is now ready to boot the Raspberry Pi.


## Connect Raspberry to host

All further commands will be executed via ssh directly on the Raspberry. For
this, the host computer needs to connect the Raspberry. There are two options:

1. Either you have connect it with your wired local network and let the router
   assign an IP address to the Raspberry via DHCP.
2. Connect the Raspberry directly via Ethernet to the host and "share" the
   Internet connection. This can be done easily from within NetworkManager.

   The following command can be used to create shared connection from the
   command line.

!!! note
	Replace the interface name (ifname) `eno1` with the name of the ethernet
	interface that will be connected to the Raspberry Pi. The interfaces can be
	inspected with `ip addr`.

```bash
# Create shared Ethernet connection via NetworkManager
nmcli connection add \
    con-name "Raspberry Pi" \
    type ethernet \
    ipv4.method shared \
    ipv4.addresses 10.43.0.1/24 \
    ifname eno1
```

!!! note
	The IP address can queries via mDNS with the hostname `raspberry.local`.
	Ensure that mDNS is available on your system, either via Avahi or
	systemd-resolve.

After figering out the connection method, insert the SD card into the
Raspberry and boot the device.

```bash
ssh pi@raspberrypi.local
```

The default Raspbian password is `raspberry`.


## SSH Public Key Authentication

The first action will be to replace the default SSH password with proper
public key authentication. Copy your public SSH key to the Raspberry:

```bash
# Executed on the host machine. Copies the public SSH key to the Raspberry
ssh-copy-id pi@raspberrypi.local

# Now, you can connect the the Raspberry without password
ssh pi@raspberrypi.local

# Executed on the Raspberry Pi. Deletes the password of the user "pi".
sudo passwd --delete pi
```

All further setup steps are performed on the Raspberry Pi.


## Audio Device Setup

The Linux audio subsystem of the WebRTC native code package searches all
available audio device. The USB microphone should be the first in this list.
For that reason, we disable the in the device tree via device tree and
rearrange the USB audio driver kernel driver load order.

```bash
# Disable raspberry audio
sudo sed -i "s/^dtparam=audio=on/# dtparam=audio=on # disabled for rpi-webrtc-streamer/" \
    /boot/config.txt

# Reorder USB audio device index
sudo sed -i "s/^options snd-usb-audio index=-2/# options snd-usb-audio index=-2 # disabled for rpi-webrtc-streamer/" \
    /lib/modprobe.d/aliases.conf
```

The gain of the microphone is increased to be more sensitive. We can either
use `alsamixer` (*F4 Capture*) or set the gain directly via command line:

!!! note
    23.81 dB (100%) might be too senstive. Choose the value that fits best
    your needs.

```bash
# Set the gain of the USB microphone to 100%
sudo amixer set 'Mic',0 100%
```


## Disable Bluetooth

Currently, FruitNanny does not use Bluetooth. In order to save power, we are
going to disable the Bluetooth chip via device tree and disable all related
services.

```bash
# Disable Bluetooth via device tree
echo -e "\n# Disable Bluetooth\ndtoverlay=pi3-disable-bt\n" \
    | sudo tee -a /boot/config.txt

# Disable Bluetooth-related services
sudo systemctl disable hciuart.service bluealsa.service bluetooth.service
```


## Enable DHT11 kernel driver

The Linux kernel contains a in-kernel driver for DHT11/21/22 devices. It can
be enabled via device tree.

```bash
# Enable in-kernel DHT22 driver via device tree
echo -e "\n# Enable DHT11/22 iio kernel driver\ndtoverlay=dht11,gpiopin=24\n" \
    | sudo tee -a /boot/config.txt
```


## Optional: Use heatbeat for activity LED

The green activity of the Raspberry Pi can be used as heartbeat beacon. It
will blink in a fixed period signalling that the device is still up and
running.

```bash
# Load LED heartbeat kernel module
sudo modprobe ledtrig-heartbeat

# Enable heartbeat for activity LED
echo heartbeat | sudo tee /sys/class/leds/led0/trigger
```


## Install NetworkManager

FruitNanny uses [NetworkManager](https://wiki.gnome.org/Projects/NetworkManager)
to control the WiFi networking via its DBus interface.

```bash
# Remove default Raspbian DHCP client
sudo apt-get remove dhcpcd5

# Install NetworkManager
sudo apt-get install network-manager
```


## Change Hostname

FruitNanny web service will be available under the mDNS hostname
`fruitnanny.local`. The standard Raspbian hostname `raspberry` will be
replaced by `fruitnanny`.

!!! note
	If you prefer a different hostname, adjust it to your liking. The hostname
	is not hard coded in the web UI and should work out-of-the box.

```bash
# Change hostname
sudo hostnamectl set-hostname fruitnanny

# Resolve new hostname to localhost
echo -e "127.0.1.1\t$(hostname)\n" | sudo tee -a /etc/hosts
```


## Enable Camera

Use `raspi-config` to enable the camera under *5 Interfacing Options* – *P1 Camera*.

```bash
sudo raspi-config
```


## Restart the Device

Now, reboot the device for all changes to take effect. The device is available
via the hostname `fruitnanny.local` (or what ever was chosen as new hostname).

```bash
# Reboot the device
sudo reboot

# Connect to the device via the new hostname
ssh pi@fruitnanny.local
```

The NetworkManager setup can be verified by running `nmcli`. You should get a
status report similar to the following:

```
eth0: connected to Wired connection 1
        "Standard SMSC9512/9514"
        ethernet (smsc95xx), B8:27:EB:1E:44:64, hw, mtu 1500
        ip4 default
        inet4 10.42.0.33/24
        route4 0.0.0.0/0
        route4 10.42.0.0/24
        inet6 fe80::e425:949f:b455:aa70/64
        route6 fe80::/64
        route6 ff00::/8

wlan0: disconnected
        "Broadcom BCM43438 combo and Bluetooth Low Energy"
        wifi (brcmfmac), 0A:08:60:BD:DB:6A, hw, mtu 1500

lo: unmanaged
        "lo"
        loopback (unknown), 00:00:00:00:00:00, sw, mtu 65536

DNS configuration:
        servers: 10.42.0.1
        interface: eth0
```


## FruitNanny Packages

Finally, the FruitNanny packages will be installed. They are provided as
Debian packages and hosted as Debian package repository via GitHub Pages.

!!!note
	The `wpasupplicant` package is a buster backport of the bullseye package.
	It provides a version 2.9.0 of wpa-supplicant which solve connection
	problems of newer Android devices with the Raspberry Pi hotspot.

```bash
# Add FruitNanny GPG key
curl -sL https://fruitnanny.github.io/pubkey.gpg | sudo apt-key add -

# Add FruitNanny repository
echo "deb https://fruitnanny.github.io/debian buster main" | sudo tee /etc/apt/sources.list.d/fruitnanny.list

# Update package index
sudo apt update

# Install WebRTC streamer, FruitNanny and wpa-supplicant packages
sudo apt install rws fruitnanny-ui fruitnanny-api wpasupplicant
```


## Configure RPi-WebRTC-Streamer

The WebRTC streamer comes with a bundled web server for static files.
FruitNanny has its own static file server.

```bash
# Disable direct socket
sudo sed -i "s/^direct_socket_enable=true/direct_socket_enable=false/" \
    /opt/rws/etc/webrtc_streamer.conf
```


## Configure wpa-supplicant

Ensure that `ap_scan` is set to `1` which means wpa-supplicant is responsible
for scanning and selecting access points. This mode is required when using the
driver `nl80211`.

```
ap_scan=1
```

```bash
# Restart to load the new configuration
sudo systemctl restart wpa_supplicant.service fruitnanny-api.service
```


## Enable Hotspot

Create the NetworkManager connection profile for the Hotspot by requesting its
connection details. These can be used to connect to the hotspot later. Enable
the hotspot.

```bash
# Show password for the hotspot
curl http://localhost/api/hotspot

# Enable the hotspot connection (if not already enabled)
sudo nmcli connection up "FruitNanny Hotspot"
```


[RPi-3B+]: https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/
