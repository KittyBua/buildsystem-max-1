#
# libdvbsi
#
LIBDVBSI_VERSION = git
LIBDVBSI_DIR     = libdvbsi.git
LIBDVBSI_SOURCE  = libdvbsi.git
LIBDVBSI_SITE    = https://github.com/OpenVisionE2
LIBDVBSI_DEPENDS = bootstrap

$(D)/libdvbsi:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
