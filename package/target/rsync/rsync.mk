#
# rsync
#
RSYNC_VERSION = 3.1.3
RSYNC_DIR     = rsync-$(RSYNC_VERSION)
RSYNC_SOURCE  = rsync-$(RSYNC_VERSION).tar.gz
RSYNC_SITE    = https://download.samba.org/pub/rsync/src
RSYNC_DEPENDS = bootstrap

RSYNC_CONF_OPTS = \
	--disable-debug \
	--disable-locale

rsync:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install-all DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
