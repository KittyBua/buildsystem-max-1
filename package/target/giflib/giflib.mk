#
# giflib
#
GIFLIB_VERSION = 5.1.4
GIFLIB_DIR     = giflib-$(GIFLIB_VERSION)
GIFLIB_SOURCE  = giflib-$(GIFLIB_VERSION).tar.bz2
GIFLIB_SITE    = https://downloads.sourceforge.net/project/giflib
GIFLIB_DEPENDS = bootstrap

$(D)/giflib:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		export ac_cv_prog_have_xmlto=no; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,gif2rgb gifbuild gifclrmp gifecho giffix gifinto giftext giftool)
	$(TOUCH)
