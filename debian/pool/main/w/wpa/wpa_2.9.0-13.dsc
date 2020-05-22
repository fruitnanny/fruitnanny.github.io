-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Format: 3.0 (quilt)
Source: wpa
Binary: hostapd, wpagui, wpasupplicant, wpasupplicant-udeb, eapoltest, libwpa-client-dev
Architecture: any
Version: 2:2.9.0-13
Maintainer: Debian wpasupplicant Maintainers <wpa@packages.debian.org>
Uploaders:  Andrej Shadura <andrewsh@debian.org>
Homepage: https://w1.fi/wpa_supplicant/
Standards-Version: 4.4.1
Vcs-Browser: https://salsa.debian.org/debian/wpa
Vcs-Git: https://salsa.debian.org/debian/wpa.git
Testsuite: autopkgtest
Testsuite-Triggers: build-essential
Build-Depends: debhelper-compat (= 12), dh-exec, libdbus-1-dev, libssl-dev, qtbase5-dev <!pkg.wpa.nogui>, libncurses5-dev, libpcsclite-dev, libnl-3-dev (>= 3.4.0~) [linux-any], libnl-genl-3-dev [linux-any], libnl-route-3-dev [linux-any], libpcap-dev [kfreebsd-any], libbsd-dev [kfreebsd-any], libreadline-dev, pkg-config, docbook-to-man, docbook-utils
Package-List:
 eapoltest deb net optional arch=any
 hostapd deb net optional arch=linux-any,kfreebsd-any
 libwpa-client-dev deb net optional arch=linux-any,kfreebsd-any
 wpagui deb net optional arch=linux-any,kfreebsd-any profile=!pkg.wpa.nogui
 wpasupplicant deb net optional arch=linux-any,kfreebsd-any
 wpasupplicant-udeb udeb debian-installer standard arch=linux-any profile=!noudeb
Checksums-Sha1:
 8c4bafede40b32890ab65ac120e1c24757878248 2347080 wpa_2.9.0.orig.tar.xz
 c5e40b2452d1f4c2b071a792ca05e67563da1e88 88600 wpa_2.9.0-13.debian.tar.xz
Checksums-Sha256:
 4032da92d97cb555053d94d514d590d0ce066ca13ba5ef144063450bc56161a7 2347080 wpa_2.9.0.orig.tar.xz
 65a74f0dd38018ca1b60be01d63561b21d4a906b65e0186a3fdbc8ae11154cf4 88600 wpa_2.9.0-13.debian.tar.xz
Files:
 132953a85df36d0fca4df129b036ca06 2347080 wpa_2.9.0.orig.tar.xz
 dc6435d1f24d00e2f1a80cd0c2bf15be 88600 wpa_2.9.0-13.debian.tar.xz

-----BEGIN PGP SIGNATURE-----

iJIEARYIADoWIQT7ocG8bXP0WZwZ1uorWqkANDNdUQUCXscd1BwcbHVjYXMua2Fo
bGVydEBzcXVhcmUtc3JjLmRlAAoJECtaqQA0M11RizYBANS6eQVw7OW44o8uYg7o
/ZkgTDWRaxltWW4jRM8SSk/mAQD7LG7zKQ3ji34IIN59XfcHoRE4YinU7Ge2CvvT
spkoDA==
=4r4x
-----END PGP SIGNATURE-----
