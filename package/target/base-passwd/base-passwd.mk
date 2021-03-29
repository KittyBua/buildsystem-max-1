#
# base-passwd
#
BASE_PASSWD_VERSION = 3.5.29
BASE_PASSWD_DIR     = base-passwd-$(BASE_PASSWD_VERSION)
BASE_PASSWD_SOURCE  = base-passwd_$(BASE_PASSWD_VERSION).tar.gz
BASE_PASSWD_SITE    = https://launchpad.net/debian/+archive/primary/+files
BASE_PASSWD_DEPENDS = bootstrap

base-passwd:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR); \
		$(INSTALL_DATA) passwd.master $(TARGET_DIR)/etc/passwd; \
		$(INSTALL_DATA) group.master $(TARGET_DIR)/etc/group
	$(REMOVE)
	$(TOUCH)
