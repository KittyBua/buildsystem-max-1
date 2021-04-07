#
# libroxml
#
LIBROXML_VERSION = 3.0.2
LIBROXML_DIR     = libroxml-$(LIBROXML_VERSION)
LIBROXML_SOURCE  = libroxml-$(LIBROXML_VERSION).tar.gz
LIBROXML_SITE    = http://download.libroxml.net/pool/v3.x
LIBROXML_DEPENDS = bootstrap

LIBROXML_CONF_OPTS = \
	--enable-shared \
	--disable-static \
	--disable-roxml

$(D)/libroxml:
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
