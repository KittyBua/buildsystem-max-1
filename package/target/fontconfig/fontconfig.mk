#
# fontconfig
#
FONTCONFIG_VERSION = 2.13.94
FONTCONFIG_DIR     = fontconfig-$(FONTCONFIG_VERSION)
FONTCONFIG_SOURCE  = fontconfig-$(FONTCONFIG_VERSION).tar.xz
FONTCONFIG_SITE    = https://www.freedesktop.org/software/fontconfig/release
FONTCONFIG_DEPENDS = bootstrap freetype expat

FONTCONFIG_CONF_OPTS = \
	--with-expat-includes=$(TARGET_INCLUDE_DIR) \
	--with-expat-lib=$(TARGET_LIB_DIR) \
	--localedir=$(REMOVE_localedir) \
	--disable-docs

$(D)/fontconfig:
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
