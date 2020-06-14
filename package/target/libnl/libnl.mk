#
# libnl
#
LIBNL_VER    = 3.5.0
LIBNL_DIR    = libnl-$(LIBNL_VER)
LIBNL_SOURCE = libnl-$(LIBNL_VER).tar.gz
LIBNL_URL    = https://github.com/thom311/libnl/releases/download/libnl3_5_0

$(D)/libnl: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
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
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
