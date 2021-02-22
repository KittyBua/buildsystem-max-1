#
# base-passwd
#
BASE_PASSWD_VER    = 3.5.29
BASE_PASSWD_DIR    = base-passwd-$(BASE_PASSWD_VER)
BASE_PASSWD_SOURCE = base-passwd_$(BASE_PASSWD_VER).tar.gz
BASE_PASSWD_SITE   = https://launchpad.net/debian/+archive/primary/+files
BASE_PASSWD_DEPS   = bootstrap

$(D)/base-passwd:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR); \
		$(INSTALL_DATA) passwd.master $(TARGET_DIR)/etc/passwd; \
		$(INSTALL_DATA) group.master $(TARGET_DIR)/etc/group
	$(REMOVE)
	$(TOUCH)
