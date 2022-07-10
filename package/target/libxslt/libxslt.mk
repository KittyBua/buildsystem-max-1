################################################################################
#
# libxslt
#
################################################################################

LIBXSLT_VERSION = 1.1.35
LIBXSLT_DIR = libxslt-$(LIBXSLT_VERSION)
LIBXSLT_SOURCE = libxslt-$(LIBXSLT_VERSION).tar.xz
LIBXSLT_SITE = https://download.gnome.org/sources/libxslt/1.1

LIBXSLT_DEPENDS = libxml2

LIBXSLT_CONFIG_SCRIPTS = xslt-config

LIBXSLT_AUTORECONF = YES

LIBXSLT_CONF_OPTS = \
	CPPFLAGS="$(CPPFLAGS) -I$(TARGET_INCLUDE_DIR)/libxml2" \
	--with-html-dir=$(REMOVE_htmldir) \
	--enable-shared \
	--disable-static \
	--with-gnu-ld \
	--without-python \
	--without-crypto \
	--without-debug \
	--without-mem-debug

define LIBXSLT_TARGET_CLEANUP
	rm -rf  $(addprefix $(TARGET_LIB_DIR)/,cmake libxslt-plugins xsltConf.sh)
endef
LIBXSLT_TARGET_CLEANUP_HOOKS += LIBXSLT_TARGET_CLEANUP

$(D)/libxslt: | bootstrap
	$(call autotools-package)
