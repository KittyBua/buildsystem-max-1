#
# libpng
#
LIBPNG_VER    = 1.6.37
LIBPNG_VER_X  = 16
LIBPNG_DIR    = libpng-$(LIBPNG_VER)
LIBPNG_SOURCE = libpng-$(LIBPNG_VER).tar.xz
LIBPNG_SITE   = https://sourceforge.net/projects/libpng/files/libpng$(LIBPNG_VER_X)/$(LIBPNG_VER)

LIBPNG_PATCH  = \
	0001-disable-pngfix-and-png-fix-itxt.patch

$(D)/libpng: bootstrap zlib
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-mips-msa \
			--disable-powerpc-vsx \
			--mandir=/.remove \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/bin/libpng*-config $(HOST_DIR)/bin/
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/libpng$(LIBPNG_VER_X)-config
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
