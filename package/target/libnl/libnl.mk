#
# libnl
#
LIBNL_VER    = 3.5.0
LIBNL_DIR    = libnl-$(LIBNL_VER)
LIBNL_SOURCE = libnl-$(LIBNL_VER).tar.gz
LIBNL_SITE   = https://github.com/thom311/libnl/releases/download/libnl3_5_0

$(D)/libnl: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--target=$(TARGET) \
			--prefix=/usr \
			--sysconfdir=/etc \
			--bindir=/.remove \
			--mandir=/.remove \
			--infodir=/.remove \
			--disable-cli \
			; \
		make; \
		make install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
