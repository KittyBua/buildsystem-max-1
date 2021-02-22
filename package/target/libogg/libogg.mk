#
# libogg
#
LIBOGG_VER    = 1.3.4
LIBOGG_DIR    = libogg-$(LIBOGG_VER)
LIBOGG_SOURCE = libogg-$(LIBOGG_VER).tar.gz
LIBOGG_SITE   = https://ftp.osuosl.org/pub/xiph/releases/ogg
LIBOGG_DEPS   = bootstrap

LIBOGG_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--enable-shared \
	--disable-static

$(D)/libogg:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
