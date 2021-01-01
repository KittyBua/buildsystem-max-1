#
# parted
#
PARTED_VER    = 3.3
PARTED_DIR    = parted-$(PARTED_VER)
PARTED_SOURCE = parted-$(PARTED_VER).tar.xz
PARTED_SITE   = https://ftp.gnu.org/gnu/parted

PARTED_CONF_OPTS = \
	--without-readline \
	--enable-shared \
	--disable-static \
	--disable-debug \
	--disable-device-mapper \
	--disable-nls

$(D)/parted: bootstrap e2fsprogs libiconv
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
