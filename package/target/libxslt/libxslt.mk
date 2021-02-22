#
# libxslt
#
LIBXSLT_VER    = 1.1.34
LIBXSLT_DIR    = libxslt-$(LIBXSLT_VER)
LIBXSLT_SOURCE = libxslt-$(LIBXSLT_VER).tar.gz
LIBXSLT_SITE   = ftp://xmlsoft.org/libxml2
LIBXSLT_DEPS   = bootstrap libxml2

LIBXSLT_CONF_OPTS = \
	CPPFLAGS="$(CPPFLAGS) -I$(TARGET_INCLUDE_DIR)/libxml2" \
	--with-html-dir=$(REMOVE_htmldir) \
	--enable-shared \
	--disable-static \
	--without-python \
	--without-crypto \
	--without-debug \
	--without-mem-debug

$(D)/libxslt:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/bin/xslt-config $(HOST_DIR)/bin
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/xslt-config
	rm -rf $(TARGETLIB)/xsltConf.sh
	rm -rf $(TARGETLIB)/libxslt-plugins/
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
