################################################################################
#
# base-passwd
#
################################################################################

BASE_PASSWD_VERSION = 3.5.29
BASE_PASSWD_DIR = base-passwd-$(BASE_PASSWD_VERSION)
BASE_PASSWD_SOURCE = base-passwd_$(BASE_PASSWD_VERSION).tar.gz
BASE_PASSWD_SITE = https://launchpad.net/debian/+archive/primary/+files

BASE_PASSWD_DEPENDS = bootstrap

define BASE_PASSWD_INSTALL_FILES
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/group.master $(TARGET_DIR)/etc/group
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/passwd.master $(TARGET_DIR)/etc/passwd
endef
BASE_PASSWD_POST_INSTALL_HOOKS += BASE_PASSWD_INSTALL_FILES

$(D)/base-passwd:
	$(call autotools-package)
