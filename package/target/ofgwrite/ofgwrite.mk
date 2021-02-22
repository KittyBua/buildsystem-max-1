#
# ofgwrite
#
OFGWRITE_VER    = git
OFGWRITE_DIR    = ofgwrite-max.git
OFGWRITE_SOURCE = ofgwrite-max.git
OFGWRITE_SITE   = $(MAX-GIT-GITHUB)
OFGWRITE_DEPS   = bootstrap

$(D)/ofgwrite:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(MAKE); \
	$(INSTALL_EXEC) $(BUILD_DIR)/$(OFGWRITE_DIR)/ofgwrite_bin $(TARGET_DIR)/usr/bin
	$(INSTALL_EXEC) $(BUILD_DIR)/$(OFGWRITE_DIR)/ofgwrite_caller $(TARGET_DIR)/usr/bin
	$(INSTALL_EXEC) $(BUILD_DIR)/$(OFGWRITE_DIR)/ofgwrite $(TARGET_DIR)/usr/bin
	$(REMOVE)
	$(TOUCH)
