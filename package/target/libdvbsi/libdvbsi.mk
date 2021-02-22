#
# libdvbsi
#
LIBDVBSI_VER    = git
LIBDVBSI_DIR    = libdvbsi.git
LIBDVBSI_SOURCE = libdvbsi.git
LIBDVBSI_SITE   = https://github.com/OpenVisionE2
LIBDVBSI_DEPS   = bootstrap

$(D)/libdvbsi:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
