#
# lzo
#
LZO_VER    = 2.10
LZO_DIR    = lzo-$(LZO_VER)
LZO_SOURCE = lzo-$(LZO_VER).tar.gz
LZO_SITE   = https://www.oberhumer.com/opensource/lzo/download
LZO_DEPS   = bootstrap

LZO_CONF_OPTS = \
	--docdir=$(REMOVE_docdir)

$(D)/lzo:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
