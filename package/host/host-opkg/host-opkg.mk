#
# host-opkg
#
HOST_OPKG_VER    = 0.3.3
HOST_OPKG_DIR    = opkg-$(HOST_OPKG_VER)
HOST_OPKG_SOURCE = opkg-$(HOST_OPKG_VER).tar.gz
HOST_OPKG_SITE   = https://git.yoctoproject.org/cgit/cgit.cgi/opkg/snapshot

HOST_OPKG_PATCH  = \
	0001-opkg.patch

$(D)/host-opkg: bootstrap host-libarchive
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		./autogen.sh $(SILENT_OPT); \
		CFLAGS="-I$(HOST_DIR)/include" \
		LDFLAGS="-L$(HOST_DIR)/lib" \
		./configure $(SILENT_OPT) \
			PKG_CONFIG_PATH=$(HOST_DIR)/lib/pkgconfig \
			--prefix= \
			--disable-curl \
			--disable-gpg \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(HOST_DIR)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
