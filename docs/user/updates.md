---
title: Software Updates
---

<img alt="Debian Package" src="../../images/deb-package.png" class="float-right">

This section describes the software update mechanisms.

The FruitNanny software is installed as Debian package froma repository hosted
at [fruitnanny.github.io](http://fruitnanny.github.io/).


## Update via SSH <small>– :material-atom: Advanced</small>

Updates can be installed the standard Debian way via `apt`. You need to access
the [FruitNanny via SSH](../network/#ssh-access-advanced).

```bash
# Download package lists
sudo apt update

# Install FruitNanny packages
sudo apt install rws wpasupplicant fruitnanny-ui fruitnanny-api
```


## Update via Web UI <small>– :material-bandage: out of order</small>

!!! warning
	Currently, there is a bug in the upgrade process via web UI leading to a
	broken package manager. Reason for this is that the upgrade process
	terminates itself before the new packages are installed.

	**Please upgrade via apt instead.**

	The package manager can be fixed with:

	```bash
	# Fix package manager
	sudo dpkg -a --configure
	```


If the FruitNanny has connection the Internet, it can check and install
updates via the web UI.

You can check for updates:

1. Go to *Settings* via app main menu in the top left corner
2. Go to the *System* tab
3. Hit *Check for Updates* button.

If updates are available, you will see a download icon in the top right
corner.

<img alt="Updates available" src="../../images/updates.jpeg" style="max-width: 300px;">

Clicking on this icon will install available updates for all
FruitNanny-related system packages.
