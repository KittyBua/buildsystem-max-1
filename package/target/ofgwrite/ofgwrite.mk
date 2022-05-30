################################################################################
#
# ofgwrite
#
################################################################################

OFGWRITE_VERSION = git
OFGWRITE_DIR     = ofgwrite-max.git
OFGWRITE_SOURCE  = ofgwrite-max.git
OFGWRITE_SITE    = $(MAX-GIT-GITHUB)
OFGWRITE_DEPENDS = bootstrap

define OFGWRITE_INSTALL_FILES
	$(INSTALL_EXEC) $(PKG_BUILD_DIR)/ofgwrite_bin $(TARGET_BIN_DIR)
	$(INSTALL_EXEC) $(PKG_BUILD_DIR)/ofgwrite_caller $(TARGET_BIN_DIR)
	$(INSTALL_EXEC) $(PKG_BUILD_DIR)/ofgwrite $(TARGET_BIN_DIR)
endef
OFGWRITE_POST_INSTALL_TARGET_HOOKS += OFGWRITE_INSTALL_FILES

$(D)/ofgwrite:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(MAKE)
	$(call TARGET_FOLLOWUP)
