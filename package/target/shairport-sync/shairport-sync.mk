#
# shairport-sync
#
SHAIRPORT_SYNC_VER    = git
SHAIRPORT_SYNC_DIR    = shairport-sync.git
SHAIRPORT_SYNC_SOURCE = shairport-sync.git
SHAIRPORT_SYNC_SITE   = https://github.com/mikebrady

SHAIRPORT_SYNC_CONF_OPTS = \
	--with-alsa \
	--with-ssl=openssl \
	--with-metadata \
	--with-tinysvcmdns \
	--with-pipe \
	--with-stdout

$(D)/shairport-sync: bootstrap libdaemon popt libconfig openssl alsa-lib
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		autoreconf -fi $(SILENT_OPT); \
		$(BUILD_ENV) \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
