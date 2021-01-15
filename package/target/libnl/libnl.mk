#
# libnl
#
LIBNL_VER    = 3.5.0
LIBNL_DIR    = libnl-$(LIBNL_VER)
LIBNL_SOURCE = libnl-$(LIBNL_VER).tar.gz
LIBNL_SITE   = https://github.com/thom311/libnl/releases/download/libnl3_5_0
LIBNL_DEPS   = bootstrap

LIBNL_CONF_OPTS = \
	--disable-cli

$(D)/libnl:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
