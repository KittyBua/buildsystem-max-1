#
# libbluray
#
LIBBLURAY_VER    = 0.9.3
LIBBLURAY_DIR    = libbluray-$(LIBBLURAY_VER)
LIBBLURAY_SOURCE = libbluray-$(LIBBLURAY_VER).tar.bz2
LIBBLURAY_URL    = ftp.videolan.org/pub/videolan/libbluray/$(LIBBLURAY_VER)

LIBBLURAY_PATCH  = \
	0001-libbluray.patch

$(D)/libbluray: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-shared \
			--disable-static \
			--disable-extra-warnings \
			--disable-doxygen-doc \
			--disable-doxygen-dot \
			--disable-doxygen-html \
			--disable-doxygen-ps \
			--disable-doxygen-pdf \
			--disable-examples \
			--disable-bdjava \
			--without-libxml2 \
			--without-fontconfig \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
