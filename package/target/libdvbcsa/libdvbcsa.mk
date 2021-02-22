#
# libdvbcsa
#
LIBDVBCSA_VER    = git
LIBDVBCSA_DIR    = libdvbcsa.git
LIBDVBCSA_SOURCE = libdvbcsa.git
LIBDVBCSA_SITE   = https://code.videolan.org/videolan
LIBDVBCSA_DEPS   = bootstrap

LIBDVBCSA_AUTORECONF = YES

$(D)/libdvbcsa:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)