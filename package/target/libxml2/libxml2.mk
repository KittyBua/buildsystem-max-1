################################################################################
#
# libxml2
#
################################################################################

LIBXML2_VERSION = 2.9.12
LIBXML2_DIR     = libxml2-$(LIBXML2_VERSION)
LIBXML2_SOURCE  = libxml2-$(LIBXML2_VERSION).tar.gz
LIBXML2_SITE    = http://xmlsoft.org/sources
LIBXML2_DEPENDS = bootstrap zlib

LIBXML2_CONFIG_SCRIPTS = xml2-config

LIBXML2_AUTORECONF = YES

LIBXML2_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--enable-shared \
	--disable-static \
	--without-python \
	--without-debug \
	--without-c14n \
	--without-legacy \
	--without-catalog \
	--without-docbook \
	--without-mem-debug \
	--without-lzma \
	--with-zlib=$(TARGET_DIR)/usr

define LIBXML2_INSTALL_FILES
	if [ -d $(TARGET_INCLUDE_DIR)/libxml2/libxml ] ; then \
		ln -sf ./libxml2/libxml $(TARGET_INCLUDE_DIR)/libxml; \
	fi
endef
LIBXML2_POST_INSTALL_TARGET_HOOKS += LIBXML2_INSTALL_FILES

define LIBXML2_CLEANUP_TARGET
	rm -f $(addprefix $(TARGET_BIN_DIR)/,xmlcatalog xmllint)
	rm -rf $(addprefix $(TARGET_LIB_DIR)/,cmake xml2Conf.sh)
endef
LIBXML2_CLEANUP_TARGET_HOOKS += LIBXML2_CLEANUP_TARGET

$(D)/libxml2:
	$(call make-package)
