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
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
