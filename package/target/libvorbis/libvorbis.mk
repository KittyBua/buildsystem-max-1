#
# libvorbis
#
LIBVORBIS_VER    = 1.3.7
LIBVORBIS_DIR    = libvorbis-$(LIBVORBIS_VER)
LIBVORBIS_SOURCE = libvorbis-$(LIBVORBIS_VER).tar.xz
LIBVORBIS_SITE   = https://ftp.osuosl.org/pub/xiph/releases/vorbis
LIBVORBIS_DEPS   = bootstrap libogg

LIBVORBIS_AUTORECONF = YES

LIBVORBIS_CONF_OPTS = \
	--disable-docs \
	--disable-examples \
	--disable-oggtest

$(D)/libvorbis:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
