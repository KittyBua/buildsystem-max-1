#
# host-opkg
#
HOST_OPKG_VERSION = 0.3.3
HOST_OPKG_DIR     = opkg-$(HOST_OPKG_VERSION)
HOST_OPKG_SOURCE  = opkg-$(HOST_OPKG_VERSION).tar.gz
HOST_OPKG_SITE    = https://git.yoctoproject.org/cgit/cgit.cgi/opkg/snapshot
HOST_OPKG_DEPENDS = bootstrap host-libarchive

HOST_OPKG_ENV = \
	CFLAGS="-I$(HOST_DIR)/include" \
	LDFLAGS="-L$(HOST_DIR)/lib"

HOST_OPKG_CONF_OPTS = \
	--disable-curl \
	--disable-gpg

host-opkg:
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
