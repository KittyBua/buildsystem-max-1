#
# pcre
#
PCRE_VER    = 8.39
PCRE_DIR    = pcre-$(PCRE_VER)
PCRE_SOURCE = pcre-$(PCRE_VER).tar.bz2
PCRE_SITE   = https://sourceforge.net/projects/pcre/files/pcre/$(PCRE_VER)

PCRE_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--enable-utf8 \
	--enable-unicode-properties

$(D)/pcre: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/bin/pcre-config $(HOST_DIR)/bin/pcre-config
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/pcre-config
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
