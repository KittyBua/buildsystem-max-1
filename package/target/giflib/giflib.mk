#
# giflib
#
GIFLIB_VER    = 5.1.4
GIFLIB_DIR    = giflib-$(GIFLIB_VER)
GIFLIB_SOURCE = giflib-$(GIFLIB_VER).tar.bz2
GIFLIB_SITE   = https://downloads.sourceforge.net/project/giflib
GIFLIB_DEPS   = bootstrap

$(D)/giflib:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		export ac_cv_prog_have_xmlto=no; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,gif2rgb gifbuild gifclrmp gifecho giffix gifinto giftext giftool)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
