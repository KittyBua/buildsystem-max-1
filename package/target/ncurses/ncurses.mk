#
# ncurses
#
NCURSES_VER    = 6.1
NCURSES_DIR    = ncurses-$(NCURSES_VER)
NCURSES_SOURCE = ncurses-$(NCURSES_VER).tar.gz
NCURSES_SITE   = https://ftp.gnu.org/pub/gnu/ncurses

NCURSES_PATCH = \
	0001-gcc-5.x-MKlib_gen.patch

NCURSES_CONF_OPTS = \
	--enable-pc-files \
	--with-pkg-config \
	--with-pkg-config-libdir=/usr/lib/pkgconfig \
	--with-shared \
	--with-fallbacks='linux vt100 xterm' \
	--without-ada \
	--without-cxx \
	--without-cxx-binding \
	--without-debug \
	--without-gpm \
	--without-manpages \
	--without-profile \
	--without-progs \
	--without-tests \
	--disable-big-core \
	--disable-rpath \
	--disable-rpath-hack \
	--enable-const \
	--enable-overwrite

$(D)/ncurses: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE); \
		$(MAKE) libs; \
		$(MAKE) install.libs DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/bin/ncurses6-config $(HOST_DIR)/bin
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/ncurses6-config
	$(PKG_REMOVE)
	$(TOUCH)
