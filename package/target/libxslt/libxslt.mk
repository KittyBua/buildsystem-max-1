#
# libxslt
#
LIBXSLT_VER    = 1.1.34
LIBXSLT_DIR    = libxslt-$(LIBXSLT_VER)
LIBXSLT_SOURCE = libxslt-$(LIBXSLT_VER).tar.gz
LIBXSLT_URL    = ftp://xmlsoft.org/libxml2

$(D)/libxslt: bootstrap libxml2
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(CONFIGURE) \
			CPPFLAGS="$(CPPFLAGS) -I$(TARGET_INCLUDE_DIR)/libxml2" \
			--prefix=/usr \
			--datarootdir=/.remove \
			--enable-shared \
			--disable-static \
			--without-python \
			--without-crypto \
			--without-debug \
			--without-mem-debug \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/bin/xslt-config $(HOST_DIR)/bin
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/xslt-config
	$(REWRITE_LIBTOOL_LA)
	rm -rf $(TARGETLIB)/xsltConf.sh
	rm -rf $(TARGETLIB)/libxslt-plugins/
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
