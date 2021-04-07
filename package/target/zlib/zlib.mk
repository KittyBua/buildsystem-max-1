#
# zlib
#
ZLIB_VERSION = 1.2.11
ZLIB_DIR     = zlib-$(ZLIB_VERSION)
ZLIB_SOURCE  = zlib-$(ZLIB_VERSION).tar.xz
ZLIB_SITE    = https://sourceforge.net/projects/libpng/files/zlib/$(ZLIB_VERSION)
ZLIB_DEPENDS = bootstrap

ZLIB_CONF_ENV = \
	mandir=$(REMOVE_mandir)

ZLIB_CONF_OPTS = \
	--prefix=/usr \
	--shared \
	--uname=Linux

$(D)/zlib:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(TARGET_CONFIGURE_OPTS) \
		./configure $($(PKG)_CONF_OPTS); \
		$(MAKE); \
		ln -sf /bin/true ldconfig; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
