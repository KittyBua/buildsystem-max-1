#
# fontconfig
#
FONTCONFIG_VER    = 2.11.93
FONTCONFIG_DIR    = fontconfig-$(FONTCONFIG_VER)
FONTCONFIG_SOURCE = fontconfig-$(FONTCONFIG_VER).tar.bz2
FONTCONFIG_SITE   = https://www.freedesktop.org/software/fontconfig/release

FONTCONFIG_PATCH = \
	0001-fontconfig-glibc.patch

FONTCONFIG_CONF_OPTS = \
	--with-freetype-config=$(HOST_DIR)/bin/freetype-config \
	--with-expat-includes=$(TARGET_INCLUDE_DIR) \
	--with-expat-lib=$(TARGET_LIB_DIR) \
	--disable-docs 

$(D)/fontconfig: bootstrap freetype expat
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
