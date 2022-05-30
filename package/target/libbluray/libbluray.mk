################################################################################
#
# libbluray
#
################################################################################

LIBBLURAY_VERSION = 1.3.1
LIBBLURAY_DIR     = libbluray-$(LIBBLURAY_VERSION)
LIBBLURAY_SOURCE  = libbluray-$(LIBBLURAY_VERSION).tar.bz2
LIBBLURAY_SITE    = http://download.videolan.org/pub/videolan/libbluray/$(LIBBLURAY_VERSION)
LIBBLURAY_DEPENDS = bootstrap freetype

LIBBLURAY_CONF_OPTS = \
	--enable-shared \
	--disable-static \
	--disable-extra-warnings \
	--disable-examples \
	--disable-bdjava-jar \
	--with-freetype \
	--without-libxml2 \
	--without-fontconfig

define LIBBLURAY_BOOTSTRAP
	$(CHDIR)/$($(PKG)_DIR); \
		./bootstrap
endef
LIBBLURAY_POST_PATCH_HOOKS += LIBBLURAY_BOOTSTRAP

$(D)/libbluray:
	$(call make-package)
