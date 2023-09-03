################################################################################
#
# freetype
#
################################################################################

FREETYPE_VERSION = 2.13.2
FREETYPE_DIR = freetype-$(FREETYPE_VERSION)
FREETYPE_SOURCE = freetype-$(FREETYPE_VERSION).tar.xz
FREETYPE_SITE = https://sourceforge.net/projects/freetype/files/freetype2/$(FREETYPE_VERSION)

FREETYPE_DEPENDS = libpng zlib

FREETYPE_CONFIG_SCRIPTS = freetype-config

FREETYPE_CONF_OPTS = \
	--enable-shared \
	--disable-static \
	--enable-freetype-config \
	--with-png \
	--with-zlib \
	--without-brotli \
	--without-bzip2 \
	--without-harfbuzz

define FREETYPE_PATCH_MODULES_CFG
	$(SED) '/^FONT_MODULES += \(type1\|cid\|pfr\|type42\|pcf\|bdf\|winfonts\|cff\)/d' $(PKG_BUILD_DIR)/modules.cfg
endef
FREETYPE_POST_PATCH_HOOKS += FREETYPE_PATCH_MODULES_CFG

define FREETYPE_EXECUTE_AUTOTOOLS
	$(CD) $(PKG_BUILD_DIR)/builds/unix; \
		libtoolize --force --copy; \
		aclocal -I .; \
		autoconf
endef
FREETYPE_PRE_CONFIGURE_HOOKS += FREETYPE_EXECUTE_AUTOTOOLS

define FREETYPE_LINK_FREETYPE
	ln -sf freetype2 $(TARGET_INCLUDE_DIR)/freetype
endef
FREETYPE_TARGET_CLEANUP_HOOKS += FREETYPE_LINK_FREETYPE

$(D)/freetype: | bootstrap
	$(call autotools-package)
