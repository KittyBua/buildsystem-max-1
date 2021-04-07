#
# ofgwrite
#
OFGWRITE_VERSION = git
OFGWRITE_DIR     = ofgwrite-max.git
OFGWRITE_SOURCE  = ofgwrite-max.git
OFGWRITE_SITE    = $(MAX-GIT-GITHUB)
OFGWRITE_DEPENDS = bootstrap

$(D)/ofgwrite:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(TARGET_CONFIGURE_OPTS) \
		$(MAKE); \
	$(INSTALL_EXEC) $(BUILD_DIR)/$(OFGWRITE_DIR)/ofgwrite_bin $(TARGET_DIR)/usr/bin
	$(INSTALL_EXEC) $(BUILD_DIR)/$(OFGWRITE_DIR)/ofgwrite_caller $(TARGET_DIR)/usr/bin
	$(INSTALL_EXEC) $(BUILD_DIR)/$(OFGWRITE_DIR)/ofgwrite $(TARGET_DIR)/usr/bin
	$(REMOVE)
	$(TOUCH)
