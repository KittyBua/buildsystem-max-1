#
# mc
#
MC_VER    = 4.8.24
MC_DIR    = mc-$(MC_VER)
MC_SOURCE = mc-$(MC_VER).tar.xz
MC_SITE   = ftp.midnight-commander.org

MC_PATCH  = \
	0001-mc-replace-perl-w-with-use-warnings.patch \
	0002-nomandate.patch \
	0003-Ticket-4070-misc-Makefile.am-install-mc.lib-only-onc.patch

$(D)/mc: bootstrap ncurses glib2
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--sysconfdir=/etc \
			--with-homedir=/var/tuxbox/config/mc \
			--disable-doxygen-doc \
			--disable-doxygen-dot \
			--disable-doxygen-html \
			--enable-charset \
			--disable-nls \
			--with-screen=ncurses \
			--without-gpm-mouse \
			--without-x \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -rf $(TARGET_SHARE_DIR)/mc/examples
	find $(TARGET_SHARE_DIR)/mc/skins -type f ! -name default.ini | xargs --no-run-if-empty rm
	$(PKG_REMOVE)
	$(TOUCH)
