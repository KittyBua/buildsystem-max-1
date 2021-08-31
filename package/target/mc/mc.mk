#
# mc
#
MC_VERSION = 4.8.27
MC_DIR     = mc-$(MC_VERSION)
MC_SOURCE  = mc-$(MC_VERSION).tar.xz
MC_SITE    = ftp.midnight-commander.org
MC_DEPENDS = bootstrap ncurses glib2

MC_AUTORECONF = YES

MC_CONF_ENV = \
	CFLAGS+=' -DNCURSES_WIDECHAR=0'

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
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	rm -rf $(TARGET_SHARE_DIR)/mc/examples
	find $(TARGET_SHARE_DIR)/mc/skins -type f ! -name default.ini | xargs --no-run-if-empty rm
	$(TOUCH)
