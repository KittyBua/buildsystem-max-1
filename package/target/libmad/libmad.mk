#
# libmad
#
LIBMAD_VER    = 0.15.1b
LIBMAD_DIR    = libmad-$(LIBMAD_VER)
LIBMAD_SOURCE = libmad-$(LIBMAD_VER).tar.gz
LIBMAD_SITE   = https://sourceforge.net/projects/mad/files/libmad/$(LIBMAD_VER)

LIBMAD_PATCH  = \
	0001-libmad-pc.patch \
	0002-libmad-frame_length.patch \
	0003-libmad-mips-h-constraint-removal.patch \
	0004-libmad-remove-deprecated-cflags.patch \
	0005-libmad-thumb2-fixed-arm.patch \
	0006-libmad-thumb2-imdct-arm.patch

$(D)/libmad: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-shared=yes \
			--enable-accuracy \
			--enable-sso \
			--disable-debugging \
			 \
			$(if $(filter $(TARGET_ARCH), arm mips),--enable-fpm=$(TARGET_ARCH),--enable-fpm=64bit) \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
