#
# mc
#
MC_VER    = 4.8.26
MC_DIR    = mc-$(MC_VER)
MC_SOURCE = mc-$(MC_VER).tar.xz
MC_SITE   = ftp.midnight-commander.org
MC_DEPS   = bootstrap ncurses glib2

MC_AUTORECONF = YES

MC_CONF_OPTS = \
	--with-homedir=/var/tuxbox/config/mc \
	--enable-charset \
	--disable-nls \
	--with-screen=ncurses \
	--without-gpm-mouse \
	--without-x

$(D)/mc:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -rf $(TARGET_SHARE_DIR)/mc/examples
	find $(TARGET_SHARE_DIR)/mc/skins -type f ! -name default.ini | xargs --no-run-if-empty rm
	$(REMOVE)
	$(TOUCH)
