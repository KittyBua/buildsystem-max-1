#
# sdparm
#
SDPARM_VER    = 1.11
SDPARM_DIR    = sdparm-$(SDPARM_VER)
SDPARM_SOURCE = sdparm-$(SDPARM_VER).tgz
SDPARM_SITE   = http://sg.danny.cz/sg/p

SDPARM_CONF_OPTS = \
	--bindir=$(base_sbindir)

$(D)/sdparm: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/sbin/,sas_disk_blink scsi_ch_swp)
	$(PKG_REMOVE)
	$(TOUCH)
