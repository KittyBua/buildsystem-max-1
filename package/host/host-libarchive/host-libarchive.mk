#
# host-libarchive
#
HOST_LIBARCHIVE_VER    = 3.4.0
HOST_LIBARCHIVE_DIR    = libarchive-$(HOST_LIBARCHIVE_VER)
HOST_LIBARCHIVE_SOURCE = libarchive-$(HOST_LIBARCHIVE_VER).tar.gz
HOST_LIBARCHIVE_SITE   = https://www.libarchive.org/downloads
HOST_LIBARCHIVE_DEPS   = bootstrap

$(D)/host-libarchive:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		./configure \
			--prefix= \
			--without-xml2 \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(HOST_DIR)
	$(REMOVE)
	$(TOUCH)
