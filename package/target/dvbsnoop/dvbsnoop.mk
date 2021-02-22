#
# dvbsnoop
#
DVBSNOOP_VER    = git
DVBSNOOP_DIR    = dvbsnoop.git
DVBSNOOP_SOURCE = dvbsnoop.git
DVBSNOOP_SITE   = https://github.com/Duckbox-Developers
DVBSNOOP_DEPS   = bootstrap kernel

DVBSNOOP_CONF_OPTS = \
	--enable-silent-rules

$(D)/dvbsnoop:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
