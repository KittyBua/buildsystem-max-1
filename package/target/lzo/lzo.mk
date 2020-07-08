#
# lzo
#
LZO_VER    = 2.10
LZO_DIR    = lzo-$(LZO_VER)
LZO_SOURCE = lzo-$(LZO_VER).tar.gz
LZO_SITE   = https://www.oberhumer.com/opensource/lzo/download

$(D)/lzo: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--docdir=/.remove \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
