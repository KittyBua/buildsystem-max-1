#
# gmp
#
GMP_VER    = 6.1.2
GMP_DIR    = gmp-$(GMP_VER)
GMP_SOURCE = gmp-$(GMP_VER).tar.xz
GMP_SITE   = https://gmplib.org/download/gmp
GMP_DEPS   = bootstrap

GMP_CONF_OPTS = \
	--enable-silent-rules

$(D)/gmp:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
