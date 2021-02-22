#
# opkg
#
OPKG_VER    = 0.3.3
OPKG_DIR    = opkg-$(OPKG_VER)
OPKG_SOURCE = opkg-$(OPKG_VER).tar.gz
OPKG_SITE   = https://git.yoctoproject.org/cgit/cgit.cgi/opkg/snapshot
OPKG_DEPS   = bootstrap host-opkg libarchive

OPKG_CONF_OPTS = \
	--disable-curl \
	--disable-gpg

$(D)/opkg:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mkdir -p $(TARGET_DIR)/usr/lib/opkg
	mkdir -p $(TARGET_DIR)/etc/opkg
	ln -sf opkg $(TARGET_DIR)/usr/bin/opkg-cl
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
