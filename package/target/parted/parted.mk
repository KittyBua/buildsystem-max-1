#
# parted
#
PARTED_VER    = 3.3
PARTED_DIR    = parted-$(PARTED_VER)
PARTED_SOURCE = parted-$(PARTED_VER).tar.xz
PARTED_SITE   = https://ftp.gnu.org/gnu/parted

PARTED_PATCH = \
	0001-fix-end_input-usage-in-do_resizepart.patch \
	0002-iconv.patch

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
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
