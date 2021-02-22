#
# sdparm
#
SDPARM_VER    = 1.11
SDPARM_DIR    = sdparm-$(SDPARM_VER)
SDPARM_SOURCE = sdparm-$(SDPARM_VER).tgz
SDPARM_SITE   = http://sg.danny.cz/sg/p
SDPARM_DEPS   = bootstrap

SDPARM_CONF_OPTS = \
	--bindir=$(base_sbindir)

$(D)/sdparm:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/sbin/,sas_disk_blink scsi_ch_swp)
	$(REMOVE)
	$(TOUCH)
