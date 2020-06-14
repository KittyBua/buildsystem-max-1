#
# shairport-sync
#
SHAIRPORT_SYNC_VER    = git
SHAIRPORT_SYNC_DIR    = shairport-sync.git
SHAIRPORT_SYNC_SOURCE = shairport-sync.git
SHAIRPORT_SYNC_URL    = https://github.com/mikebrady

$(D)/shairport-sync: bootstrap libdaemon popt libconfig openssl alsa-lib
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(CPDIR)/$(PKG_DIR)
	$(CHDIR)/$(PKG_DIR); \
		autoreconf -fi $(SILENT_OPT); \
		$(BUILD_ENV) \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--with-alsa \
			--with-ssl=openssl \
			--with-metadata \
			--with-tinysvcmdns \
			--with-pipe \
			--with-stdout \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
