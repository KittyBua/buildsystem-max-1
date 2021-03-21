#
# dvbsnoop
#
DVBSNOOP_VERSION = git
DVBSNOOP_DIR     = dvbsnoop.git
DVBSNOOP_SOURCE  = dvbsnoop.git
DVBSNOOP_SITE    = https://github.com/Duckbox-Developers
DVBSNOOP_DEPENDS = bootstrap kernel

DVBSNOOP_CONF_OPTS = \
	--enable-silent-rules

$(D)/dvbsnoop:
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
	$(TOUCH)
