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
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
