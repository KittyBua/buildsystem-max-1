#
# host-opkg
#
HOST_OPKG_VER    = 0.3.3
HOST_OPKG_DIR    = opkg-$(HOST_OPKG_VER)
HOST_OPKG_SOURCE = opkg-$(HOST_OPKG_VER).tar.gz
HOST_OPKG_SITE   = https://git.yoctoproject.org/cgit/cgit.cgi/opkg/snapshot
HOST_OPKG_DEPS   = bootstrap host-libarchive

$(D)/host-opkg:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		./autogen.sh; \
		CFLAGS="-I$(HOST_DIR)/include" \
		LDFLAGS="-L$(HOST_DIR)/lib" \
		./configure \
			PKG_CONFIG_PATH=$(HOST_DIR)/lib/pkgconfig \
			--prefix= \
			--disable-curl \
			--disable-gpg \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(HOST_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
