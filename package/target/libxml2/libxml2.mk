#
# libxml2
#
LIBXML2_VER    = 2.9.10
LIBXML2_DIR    = libxml2-$(LIBXML2_VER)
LIBXML2_SOURCE = libxml2-$(LIBXML2_VER).tar.gz
LIBXML2_SITE   = http://xmlsoft.org/sources

LIBXML2_PATCH = \
	0001-libxml2.patch \
	0002-no_docs_examples_tests.patch \
	0003-revert-Make-xmlFreeNodeList-non-recursive.patch

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

$(D)/libxml2: bootstrap zlib
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	if [ -d $(TARGET_INCLUDE_DIR)/libxml2/libxml ] ; then \
		ln -sf ./libxml2/libxml $(TARGET_INCLUDE_DIR)/libxml; \
	fi
	mv $(TARGET_DIR)/usr/bin/xml2-config $(HOST_DIR)/bin
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/xml2-config
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,xmlcatalog xmllint)
	rm -rf $(TARGET_LIB_DIR)/xml2Conf.sh
	rm -rf $(TARGET_LIB_DIR)/cmake
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
