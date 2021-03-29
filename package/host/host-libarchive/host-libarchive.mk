#
# host-libarchive
#
HOST_LIBARCHIVE_VERSION = 3.4.0
HOST_LIBARCHIVE_DIR     = libarchive-$(HOST_LIBARCHIVE_VERSION)
HOST_LIBARCHIVE_SOURCE  = libarchive-$(HOST_LIBARCHIVE_VERSION).tar.gz
HOST_LIBARCHIVE_SITE    = https://www.libarchive.org/downloads
HOST_LIBARCHIVE_DEPENDS = bootstrap

HOST_LIBARCHIVE_CONF_OPTS = \
	--without-xml2

host-libarchive:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(HOST_CONFIGURE); \
		$(MAKE); \
		$(MAKE) install
	$(REMOVE)
	$(TOUCH)
