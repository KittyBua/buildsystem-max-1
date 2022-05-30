################################################################################
#
# lcd4linux
#
################################################################################

LCD4LINUX_VERSION = git
LCD4LINUX_DIR     = lcd4linux.git
LCD4LINUX_SOURCE  = lcd4linux.git
LCD4LINUX_SITE    = https://github.com/TangoCash
LCD4LINUX_DEPENDS = bootstrap $(SHARE_NEUTRINO_LCD4LINUX) ncurses libusb-compat libgd libusb libdpf

LCD4LINUX_CONF_OPTS = \
	--with-drivers='DPF,SamsungSPF,VUPLUS4K,PNG' \
	--with-plugins='all,!apm,!asterisk,!dbus,!dvb,!gps,!hddtemp,!huawei,!imon,!isdn,!kvv,!mpd,!mpris_dbus,!mysql,!pop3,!ppp,!python,!qnaplog,!raspi,!sample,!seti,!w1retap,!wireless,!xmms' \
	--with-ncurses=$(TARGET_LIB_DIR)

define LCD4LINUX_INSTALL_FILES
	cp -a $(PKG_FILES_DIR)/icons/* $(SHARE_NEUTRINO_LCD4LINUX)
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/lcd4linux.init $(TARGET_DIR)/etc/init.d/lcd4linux
	$(INSTALL_CONF) $(PKG_FILES_DIR)/lcd4config.conf $(TARGET_DIR)/etc/lcd4config.conf
	$(INSTALL_CONF) $(PKG_FILES_DIR)/lcd4linux.conf $(TARGET_DIR)/etc/lcd4linux.conf
	$(INSTALL_CONF) $(PKG_FILES_DIR)/lcd4linux-var.conf $(TARGET_DIR)/var/etc/lcd4linux.conf
endef
LCD4LINUX_POST_INSTALL_TARGET_HOOKS += LCD4LINUX_INSTALL_FILES

$(D)/lcd4linux:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		./bootstrap; \
		$(CONFIGURE); \
		$(MAKE) vcs_version; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(call TARGET_FOLLOWUP)
