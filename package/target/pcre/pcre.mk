#
# pcre
#
PCRE_VER    = 8.39
PCRE_DIR    = pcre-$(PCRE_VER)
PCRE_SOURCE = pcre-$(PCRE_VER).tar.bz2
PCRE_SITE   = https://sourceforge.net/projects/pcre/files/pcre/$(PCRE_VER)

$(D)/pcre: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--docdir=/.remove \
			--enable-utf8 \
			--enable-unicode-properties \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/bin/pcre-config $(HOST_DIR)/bin/pcre-config
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/pcre-config
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
