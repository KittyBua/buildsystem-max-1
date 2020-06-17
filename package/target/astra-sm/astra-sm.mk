#
# astra-sm
#
ASTRA_SM_VER    = git
ASTRA_SM_DIR    = astra-sm.git
ASTRA_SM_SOURCE = astra-sm.git
ASTRA_SM_SITE   = https://gitlab.com/crazycat69

ASTRA_SM_PATCH  = \
	0001-astra-sm.patch

$(D)/astra-sm: bootstrap openssl
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(ASTRA_SM_DIR)
	$(CPDIR)/$(ASTRA_SM_DIR)
	$(CHDIR)/$(ASTRA_SM_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		sed -i 's:(CFLAGS):(CFLAGS_FOR_BUILD):' tools/Makefile.am; \
		$(CONFIGURE) \
			--prefix=/usr \
			--sysconfdir=/etc \
			--without-lua \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/$(ASTRA_SM_DIR)
	$(TOUCH)
