#
# libxml2
#
LIBXML2_VER    = 2.9.10
LIBXML2_DIR    = libxml2-$(LIBXML2_VER)
LIBXML2_SOURCE = libxml2-$(LIBXML2_VER).tar.gz
LIBXML2_SITE   = http://xmlsoft.org/sources
LIBXML2_DEPS   = bootstrap zlib

LIBXML2_AUTORECONF = YES

LIBXML2_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--enable-shared \
	--disable-static \
	--without-python \
	--without-catalog \
	--without-debug \
	--without-legacy \
	--without-docbook \
	--without-mem-debug \
	--without-lzma \
	--with-zlib=$(TARGET_DIR)/usr

$(D)/libxml2:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	if [ -d $(TARGET_INCLUDE_DIR)/libxml2/libxml ] ; then \
		ln -sf ./libxml2/libxml $(TARGET_INCLUDE_DIR)/libxml; \
	fi
	mv $(TARGET_DIR)/usr/bin/xml2-config $(HOST_DIR)/bin
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/xml2-config
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,xmlcatalog xmllint)
	rm -rf $(addprefix $(TARGET_LIB_DIR)/,cmake xml2Conf.sh)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
