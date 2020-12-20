#
# libroxml
#
LIBROXML_VER    = 3.0.2
LIBROXML_DIR    = libroxml-$(LIBROXML_VER)
LIBROXML_SOURCE = libroxml-$(LIBROXML_VER).tar.gz
LIBROXML_SITE   = http://download.libroxml.net/pool/v3.x

LIBROXML_PATCH = \
	0001-fix-build-with-fno-common.patch

LIBROXML_CONF_OPTS = \
	--enable-shared \
	--disable-static \
	--disable-roxml

$(D)/libroxml: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
