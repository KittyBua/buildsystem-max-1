#
# sdparm
#
SDPARM_VERSION = 1.11
SDPARM_DIR     = sdparm-$(SDPARM_VERSION)
SDPARM_SOURCE  = sdparm-$(SDPARM_VERSION).tgz
SDPARM_SITE    = http://sg.danny.cz/sg/p
SDPARM_DEPENDS = bootstrap

SDPARM_CONF_OPTS = \
	--bindir=$(base_sbindir)

$(D)/sdparm:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	rm -f $(addprefix $(TARGET_DIR)/sbin/,sas_disk_blink scsi_ch_swp)
	$(TOUCH)
