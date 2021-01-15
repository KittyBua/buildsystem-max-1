#
# fontconfig
#
FONTCONFIG_VER    = 2.11.93
FONTCONFIG_DIR    = fontconfig-$(FONTCONFIG_VER)
FONTCONFIG_SOURCE = fontconfig-$(FONTCONFIG_VER).tar.bz2
FONTCONFIG_SITE   = https://www.freedesktop.org/software/fontconfig/release
FONTCONFIG_DEPS   = bootstrap freetype expat

FONTCONFIG_CONF_OPTS = \
	--with-freetype-config=$(HOST_DIR)/bin/freetype-config \
	--with-expat-includes=$(TARGET_INCLUDE_DIR) \
	--with-expat-lib=$(TARGET_LIB_DIR) \
	--disable-docs 

$(D)/fontconfig:
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
