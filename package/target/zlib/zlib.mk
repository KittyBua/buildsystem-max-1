#
# zlib
#
ZLIB_VER    = 1.2.11
ZLIB_DIR    = zlib-$(ZLIB_VER)
ZLIB_SOURCE = zlib-$(ZLIB_VER).tar.xz
ZLIB_SITE   = https://sourceforge.net/projects/libpng/files/zlib/$(ZLIB_VER)
ZLIB_DEPS   = bootstrap

ZLIB_CONF_OPTS = \
	--prefix=/usr \
	--shared \
	--uname=Linux

$(D)/zlib:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(TARGET_CONFIGURE_ENV) \
		mandir=$(REMOVE_mandir) \
		./configure $($(PKG)_CONF_OPTS); \
		$(MAKE); \
		ln -sf /bin/true ldconfig; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
