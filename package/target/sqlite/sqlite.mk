#
# sqlite
#
SQLITE_VER    = 3330000
SQLITE_DIR    = sqlite-autoconf-$(SQLITE_VER)
SQLITE_SOURCE = sqlite-autoconf-$(SQLITE_VER).tar.gz
SQLITE_SITE   = http://www.sqlite.org/2020

$(D)/sqlite: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,sqlite3)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
