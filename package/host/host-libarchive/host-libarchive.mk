#
# host-libarchive
#
HOST_LIBARCHIVE_VER    = 3.4.0
HOST_LIBARCHIVE_DIR    = libarchive-$(HOST_LIBARCHIVE_VER)
HOST_LIBARCHIVE_SOURCE = libarchive-$(HOST_LIBARCHIVE_VER).tar.gz
HOST_LIBARCHIVE_SITE   = https://www.libarchive.org/downloads

$(D)/host-libarchive: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		./configure $(SILENT_OPT) \
			--build=$(BUILD) \
			--host=$(BUILD) \
			--prefix= \
			--without-xml2 \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(HOST_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
