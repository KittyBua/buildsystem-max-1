################################################################################
#
# zlib
#
################################################################################

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
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE_ENV) \
		./configure $($(PKG)_CONF_OPTS); \
		$(MAKE); \
		ln -sf /bin/true ldconfig; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(call TARGET_FOLLOWUP)
