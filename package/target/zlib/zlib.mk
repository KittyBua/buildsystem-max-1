#
# zlib
#
ZLIB_VER    = 1.2.11
ZLIB_DIR    = zlib-$(ZLIB_VER)
ZLIB_SOURCE = zlib-$(ZLIB_VER).tar.xz
ZLIB_SITE   = https://sourceforge.net/projects/libpng/files/zlib/$(ZLIB_VER)

ZLIB_PATCH = \
	0001-zlib.patch

ZLIB_CONF_OPTS = \
	--prefix=/usr \
	--shared \
	--uname=Linux

$(D)/zlib: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(BUILD_ENV) \
		mandir=$(REMOVE_mandir) \
		./configure $(SILENT_OPT) $(PKG_CONF_OPTS); \
		$(MAKE); \
		ln -sf /bin/true ldconfig; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
