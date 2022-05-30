################################################################################
#
# libxslt
#
################################################################################

LIBXSLT_VERSION = 1.1.34
LIBXSLT_DIR     = libxslt-$(LIBXSLT_VERSION)
LIBXSLT_SOURCE  = libxslt-$(LIBXSLT_VERSION).tar.gz
LIBXSLT_SITE    = ftp://xmlsoft.org/libxml2
LIBXSLT_DEPENDS = bootstrap libxml2

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

define LIBXSLT_CLEANUP_TARGET
	rm -rf  $(addprefix $(TARGET_LIB_DIR)/,libxslt-plugins xsltConf.sh)
endef
LIBXSLT_CLEANUP_TARGET_HOOKS += LIBXSLT_CLEANUP_TARGET

$(D)/libxslt:
	$(call make-package)
