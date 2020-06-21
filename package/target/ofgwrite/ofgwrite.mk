#
# ofgwrite
#
OFGWRITE_VER    = git
OFGWRITE_DIR    = ofgwrite-max.git
OFGWRITE_SOURCE = ofgwrite-max.git
OFGWRITE_SITE   = $(MAX-GIT-GITHUB)

$(D)/ofgwrite: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(CPDIR)/$(PKG_DIR)
	$(CHDIR)/$(PKG_DIR); \
		$(BUILD_ENV) \
		$(MAKE); \
	$(INSTALL_EXEC) $(BUILD_DIR)/$(OFGWRITE_DIR)/ofgwrite_bin $(TARGET_DIR)/usr/bin
	$(INSTALL_EXEC) $(BUILD_DIR)/$(OFGWRITE_DIR)/ofgwrite_caller $(TARGET_DIR)/usr/bin
	$(INSTALL_EXEC) $(BUILD_DIR)/$(OFGWRITE_DIR)/ofgwrite $(TARGET_DIR)/usr/bin
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
