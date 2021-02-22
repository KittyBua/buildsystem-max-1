#
# freetype
#
FREETYPE_VER    = 2.10.4
FREETYPE_DIR    = freetype-$(FREETYPE_VER)
FREETYPE_SOURCE = freetype-$(FREETYPE_VER).tar.xz
FREETYPE_SITE   = https://sourceforge.net/projects/freetype/files/freetype2/$(FREETYPE_VER)
FREETYPE_DEPS   = bootstrap zlib libpng

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
	mv $(TARGET_DIR)/usr/bin/freetype-config $(HOST_DIR)/bin
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/freetype-config
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
