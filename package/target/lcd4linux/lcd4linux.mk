#
# lcd4linux
#
LCD4LINUX_VER    = git
LCD4LINUX_DIR    = lcd4linux.git
LCD4LINUX_SOURCE = lcd4linux.git
LCD4LINUX_SITE   = https://github.com/TangoCash

$(D)/lcd4linux: bootstrap $(SHARE_LCD4LINUX) ncurses libusb-compat libgd libusb libdpf
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(BUILD_ENV) ./bootstrap $(SILENT_OPT); \
		$(BUILD_ENV) ./configure $(CONFIGURE_OPTS) $(SILENT_OPT) \
			--prefix=/usr \
			--with-drivers='DPF,SamsungSPF,VUPLUS4K,PNG' \
			--with-plugins='all,!apm,!asterisk,!dbus,!dvb,!gps,!hddtemp,!huawei,!imon,!isdn,!kvv,!mpd,!mpris_dbus,!mysql,!pop3,!ppp,!python,!qnaplog,!raspi,!sample,!seti,!w1retap,!wireless,!xmms' \
			--with-ncurses=$(TARGET_LIB_DIR) \
			; \
		$(MAKE) vcs_version all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	cp -a $(PKG_FILES_DIR)/icons/* $(SHARE_LCD4LINUX)
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/lcd4linux.init $(TARGET_DIR)/etc/init.d/lcd4linux
	$(INSTALL_CONF) $(PKG_FILES_DIR)/lcd4linux.conf $(TARGET_DIR)/etc/lcd4linux.conf
	$(INSTALL_CONF) $(PKG_FILES_DIR)/lcd4linux-var.conf $(TARGET_DIR)/var/etc/lcd4linux.conf
	$(PKG_REMOVE)
	$(TOUCH)
