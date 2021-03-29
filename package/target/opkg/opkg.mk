#
# opkg
#
OPKG_VERSION = 0.3.3
OPKG_DIR     = opkg-$(OPKG_VERSION)
OPKG_SOURCE  = opkg-$(OPKG_VERSION).tar.gz
OPKG_SITE    = https://git.yoctoproject.org/cgit/cgit.cgi/opkg/snapshot
OPKG_DEPENDS = bootstrap host-opkg libarchive

OPKG_CONF_OPTS = \
	--disable-curl \
	--disable-gpg

opkg:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mkdir -p $(TARGET_DIR)/usr/lib/opkg
	mkdir -p $(TARGET_DIR)/etc/opkg
	ln -sf opkg $(TARGET_DIR)/usr/bin/opkg-cl
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
