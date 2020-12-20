#
# mc
#
MC_VER    = 4.8.25
MC_DIR    = mc-$(MC_VER)
MC_SOURCE = mc-$(MC_VER).tar.xz
MC_SITE   = ftp.midnight-commander.org

MC_PATCH = \
	0001-mc-replace-perl-w-with-use-warnings.patch \
	0002-nomandate.patch \
	0003-subshell.patch \
	0004-fix-mouse-handling-newer-terminfo.patch

MC_CONF_OPTS = \
	--with-homedir=/var/tuxbox/config/mc \
	--enable-charset \
	--disable-nls \
	--with-screen=ncurses \
	--without-gpm-mouse \
	--without-x

$(D)/mc: bootstrap ncurses glib2
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -rf $(TARGET_SHARE_DIR)/mc/examples
	find $(TARGET_SHARE_DIR)/mc/skins -type f ! -name default.ini | xargs --no-run-if-empty rm
	$(PKG_REMOVE)
	$(TOUCH)
