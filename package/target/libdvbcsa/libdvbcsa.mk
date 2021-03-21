#
# libdvbcsa
#
LIBDVBCSA_VERSION = git
LIBDVBCSA_DIR     = libdvbcsa.git
LIBDVBCSA_SOURCE  = libdvbcsa.git
LIBDVBCSA_SITE    = https://code.videolan.org/videolan
LIBDVBCSA_DEPENDS = bootstrap

LIBDVBCSA_AUTORECONF = YES

$(D)/libdvbcsa:
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