#
# freetype
#
FREETYPE_VERSION = 2.11.0
FREETYPE_DIR     = freetype-$(FREETYPE_VERSION)
FREETYPE_SOURCE  = freetype-$(FREETYPE_VERSION).tar.xz
FREETYPE_SITE    = https://sourceforge.net/projects/freetype/files/freetype2/$(FREETYPE_VERSION)
FREETYPE_DEPENDS = bootstrap zlib libpng

define FREETYPE_POST_PATCH
	$(SED) '/^FONT_MODULES += \(type1\|cid\|pfr\|type42\|pcf\|bdf\|winfonts\|cff\)/d' $(PKG_BUILD_DIR)/modules.cfg
endef
FREETYPE_POST_PATCH_HOOKS = FREETYPE_POST_PATCH

FREETYPE_CONF_OPTS = \
	--enable-shared \
	--disable-static \
	--enable-freetype-config \
	--with-png \
	--with-zlib \
	--without-harfbuzz \
	--without-bzip2 \
	--without-brotli

FREETYPE_CONFIG_SCRIPTS = freetype-config

$(D)/freetype:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR)/builds/unix; \
		libtoolize --force --copy; \
		aclocal -I .; \
		autoconf
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	ln -sf freetype2 $(TARGET_INCLUDE_DIR)/freetype
	$(REWRITE_CONFIG_SCRIPTS)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
