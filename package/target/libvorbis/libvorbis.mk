#
# libvorbis
#
LIBVORBIS_VER    = 1.3.6
LIBVORBIS_DIR    = libvorbis-$(LIBVORBIS_VER)
LIBVORBIS_SOURCE = libvorbis-$(LIBVORBIS_VER).tar.xz
LIBVORBIS_SITE   = https://ftp.osuosl.org/pub/xiph/releases/vorbis

LIBVORBIS_PATCH = \
	0001-configure-Check-for-clang.patch \
	0002-CVE-2017-14160.patch \
	0003-CVE-2018-10392.patch

$(D)/libvorbis: bootstrap libogg
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--docdir=/.remove \
			--mandir=/.remove \
			--disable-docs \
			--disable-examples \
			--disable-oggtest \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR) docdir=/.remove
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
