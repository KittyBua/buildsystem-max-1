#
# lsb
#
LSB_VER    = 3.2-20
LSB_DIR    = lsb-3.2
LSB_SOURCE = lsb_$(LSB_VER).tar.gz
LSB_SITE   = https://debian.sdinet.de/etch/sdinet/lsb

$(D)/lsb: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(INSTALL_DATA) init-functions $(TARGET_DIR)/lib/lsb
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
