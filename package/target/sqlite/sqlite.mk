#
# sqlite
#
SQLITE_VER    = 3330000
SQLITE_DIR    = sqlite-autoconf-$(SQLITE_VER)
SQLITE_SOURCE = sqlite-autoconf-$(SQLITE_VER).tar.gz
SQLITE_SITE   = http://www.sqlite.org/2020
SQLITE_DEPS   = bootstrap

$(D)/sqlite:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,sqlite3)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
