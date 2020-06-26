#
# lsb
#
LSB_VER    = 3.2-20
LSB_DIR    = lsb-3.2
LSB_SOURCE = lsb_$(LSB_VER).tar.gz
LSB_SITE   = https://debian.sdinet.de/etch/sdinet/lsb

$(D)/lsb: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(INSTALL_DATA) init-functions $(TARGET_DIR)/lib/lsb
	$(PKG_REMOVE)
	$(TOUCH)
