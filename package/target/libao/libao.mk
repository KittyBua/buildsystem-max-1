#
# libao
#
LIBAO_VER    = 1.1.0
LIBAO_DIR    = libao-$(LIBAO_VER)
LIBAO_SOURCE = libao-$(LIBAO_VER).tar.gz
LIBAO_SITE   = https://ftp.osuosl.org/pub/xiph/releases/ao

LIBAO_PATCH  = \
	0001-no-docs.patch

$(D)/libao: bootstrap alsa-lib
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--datadir=/.remove \
			--infodir=/.remove \
			--enable-shared \
			--disable-static \
			--enable-alsa \
			--enable-alsa-mmap \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
