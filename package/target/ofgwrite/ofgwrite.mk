################################################################################
#
# ofgwrite
#
################################################################################

OFGWRITE_VERSION = git
OFGWRITE_DIR = ofgwrite-max.git
OFGWRITE_SOURCE = ofgwrite-max.git
OFGWRITE_SITE = $(MAX-GIT-GITHUB)

OFGWRITE_DEPENDS = bootstrap

OFGWRITE_MAKE_ENV = \
	$(TARGET_CONFIGURE_ENV)

define OFGWRITE_INSTALL_BINARY
	$(INSTALL_EXEC) $(PKG_BUILD_DIR)/ofgwrite_bin $(TARGET_BIN_DIR)
	$(INSTALL_EXEC) $(PKG_BUILD_DIR)/ofgwrite_caller $(TARGET_BIN_DIR)
	$(INSTALL_EXEC) $(PKG_BUILD_DIR)/ofgwrite $(TARGET_BIN_DIR)
endef
OFGWRITE_POST_FOLLOWUP_HOOKS += OFGWRITE_INSTALL_BINARY

$(D)/ofgwrite:
	$(call generic-package,$(PKG_NO_INSTALL))
