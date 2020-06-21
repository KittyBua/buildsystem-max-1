#
# libdvbsi
#
LIBDVBSI_VER    = git
LIBDVBSI_DIR    = libdvbsi.git
LIBDVBSI_SOURCE = libdvbsi.git
LIBDVBSI_SITE   = https://github.com/OpenVisionE2

LIBDVBSI_PATCH  = \
	0001-content_identifier_descriptor.patch

$(D)/libdvbsi: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(CPDIR)/$(PKG_DIR)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
