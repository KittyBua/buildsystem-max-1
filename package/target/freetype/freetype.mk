#
# freetype
#
FREETYPE_VER    = 2.10.2
FREETYPE_DIR    = freetype-$(FREETYPE_VER)
FREETYPE_SOURCE = freetype-$(FREETYPE_VER).tar.xz
FREETYPE_SITE   = https://sourceforge.net/projects/freetype/files/freetype2/$(FREETYPE_VER)

FREETYPE_PATCH  = \
	0001-freetype2-subpixel.patch \
	0002-freetype2-config.patch \
	0003-freetype2-pkgconf.patch

$(D)/freetype: bootstrap zlib libpng
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		sed -i '/^FONT_MODULES += \(type1\|cid\|pfr\|type42\|pcf\|bdf\|winfonts\|cff\)/d' modules.cfg
	$(PKG_CHDIR)/builds/unix; \
		libtoolize --force --copy $(SILENT_OPT); \
		aclocal -I .; \
		autoconf
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--enable-shared \
			--disable-static \
			--enable-freetype-config \
			--with-png \
			--with-zlib \
			--without-harfbuzz \
			--without-bzip2 \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	ln -sf freetype2 $(TARGET_INCLUDE_DIR)/freetype
	mv $(TARGET_DIR)/usr/bin/freetype-config $(HOST_DIR)/bin
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/freetype-config
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
