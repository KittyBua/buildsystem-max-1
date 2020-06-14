#
# libao
#
LIBAO_VER    = 1.1.0
LIBAO_DIR    = libao-$(LIBAO_VER)
LIBAO_SOURCE = libao-$(LIBAO_VER).tar.gz
LIBAO_URL    = https://ftp.osuosl.org/pub/xiph/releases/ao

$(D)/libao: bootstrap alsa-lib
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
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
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
