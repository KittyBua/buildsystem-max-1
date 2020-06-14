#
# opkg
#
OPKG_VER    = 0.3.3
OPKG_DIR    = opkg-$(OPKG_VER)
OPKG_SOURCE = opkg-$(OPKG_VER).tar.gz
OPKG_URL    = https://git.yoctoproject.org/cgit/cgit.cgi/opkg/snapshot

OPKG_PATCH = \
	0001-opkg.patch

$(D)/opkg: bootstrap host-opkg libarchive
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		LIBARCHIVE_LIBS="-L$(TARGET_DIR)/usr/lib -larchive" \
		LIBARCHIVE_CFLAGS="-I$(TARGET_DIR)/usr/include" \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-curl \
			--disable-gpg \
			--mandir=/.remove \
			; \
		$(MAKE) all ; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mkdir -p $(TARGET_DIR)/usr/lib/opkg
	mkdir -p $(TARGET_DIR)/etc/opkg
	ln -sf opkg $(TARGET_DIR)/usr/bin/opkg-cl
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
