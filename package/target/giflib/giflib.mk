#
# giflib
#
GIFLIB_VER    = 5.1.4
GIFLIB_DIR    = giflib-$(GIFLIB_VER)
GIFLIB_SOURCE = giflib-$(GIFLIB_VER).tar.bz2
GIFLIB_SITE   = https://sourceforge.net/projects/giflib/files

$(D)/giflib: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		export ac_cv_prog_have_xmlto=no; \
		$(CONFIGURE) \
			--prefix=/usr \
			--bindir=/.remove \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,gif2rgb gifbuild gifclrmp gifecho giffix gifinto giftext giftool)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
