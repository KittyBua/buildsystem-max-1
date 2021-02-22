#
# pcre
#
PCRE_VER    = 8.39
PCRE_DIR    = pcre-$(PCRE_VER)
PCRE_SOURCE = pcre-$(PCRE_VER).tar.bz2
PCRE_SITE   = https://sourceforge.net/projects/pcre/files/pcre/$(PCRE_VER)
PCRE_DEPS   = bootstrap

PCRE_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--enable-utf8 \
	--enable-unicode-properties

$(D)/pcre:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/bin/pcre-config $(HOST_DIR)/bin/pcre-config
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/pcre-config
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
