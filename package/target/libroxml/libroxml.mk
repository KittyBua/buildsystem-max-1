################################################################################
#
# libroxml
#
################################################################################

LIBROXML_VERSION = 3.0.2
LIBROXML_DIR = libroxml-$(LIBROXML_VERSION)
LIBROXML_SOURCE = libroxml-$(LIBROXML_VERSION).tar.gz
LIBROXML_SITE = http://download.libroxml.net/pool/v3.x

LIBROXML_DEPENDS = bootstrap

LIBROXML_CONF_OPTS = \
	--enable-shared \
	--disable-static \
	--disable-roxml

$(D)/libroxml:
	$(call autotools-package)
