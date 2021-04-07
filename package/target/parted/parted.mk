#
# parted
#
PARTED_VERSION = 3.2
PARTED_DIR     = parted-$(PARTED_VERSION)
PARTED_SOURCE  = parted-$(PARTED_VERSION).tar.xz
PARTED_SITE    = https://ftp.gnu.org/gnu/parted
PARTED_DEPENDS = bootstrap e2fsprogs libiconv

PARTED_AUTORECONF = YES

PARTED_CONF_OPTS = \
	--without-readline \
	--enable-shared \
	--disable-static \
	--disable-debug \
	--disable-device-mapper \
	--disable-nls

$(D)/parted:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
