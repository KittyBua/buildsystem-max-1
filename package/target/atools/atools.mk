#
# atools
#
HAT_CORE_REV          = 2314b11
HAT_CORE_SOURCE       = hat-core-$(HAT_CORE_REV).tar.bz2
HAT_EXTRAS_REV        = 3ecbe8d
HAT_EXTRAS_SOURCE     = hat-extras-$(HAT_EXTRAS_REV).tar.bz2
HAT_LIBSELINUX_REV    = 07e9e13
HAT_LIBSELINUX_SOURCE = hat-libselinux-$(HAT_LIBSELINUX_REV).tar.bz2
HAT_MIRROR_SITE       = https://android.googlesource.com/platform

$(DL_DIR)/$(HAT_CORE_SOURCE):
	$(GET-GIT-ARCHIVE) $(HAT_MIRROR_SITE)/system/core $(HAT_CORE_REV) $(notdir $@) $(DL_DIR)

$(DL_DIR)/$(HAT_EXTRAS_SOURCE):
	$(GET-GIT-ARCHIVE) $(HAT_MIRROR_SITE)/system/extras $(HAT_EXTRAS_REV) $(notdir $@) $(DL_DIR)

$(DL_DIR)/$(HAT_LIBSELINUX_SOURCE):
	$(GET-GIT-ARCHIVE) $(HAT_MIRROR_SITE)/external/libselinux $(HAT_LIBSELINUX_REV) $(notdir $@) $(DL_DIR)

$(D)/atools: $(DL_DIR)/$(HAT_CORE_SOURCE) $(DL_DIR)/$(HAT_EXTRAS_SOURCE) $(DL_DIR)/$(HAT_LIBHARDWARE_SOURCE) $(DL_DIR)/$(HAT_LIBSELINUX_SOURCE) $(DL_DIR)/$(HAT_BUILD_SOURCE)
	$(START_BUILD)
	$(REMOVE)/hat
	$(MKDIR)/hat/system/core
	$(SILENT)tar --strip 1 -C $(BUILD_DIR)/hat/system/core -xf $(DL_DIR)/$(HAT_CORE_SOURCE)
	$(MKDIR)/hat/system/extras
	$(SILENT)tar --strip 1 -C $(BUILD_DIR)/hat/system/extras -xf $(DL_DIR)/$(HAT_EXTRAS_SOURCE)
	$(MKDIR)/hat/external/libselinux
	$(SILENT)tar --strip 1 -C $(BUILD_DIR)/hat/external/libselinux -xf $(DL_DIR)/$(HAT_LIBSELINUX_SOURCE)
	$(INSTALL_DATA) $(PKG_FILES_DIR)/ext4_utils.helper $(BUILD_DIR)/hat/ext4_utils.mk
	$(CHDIR)/hat; \
		$(MAKE) --file=ext4_utils.mk SRCDIR=$(BUILD_DIR)/hat
		$(INSTALL_EXEC) -D $(BUILD_DIR)/hat/ext2simg $(HOST_DIR)/bin/
		$(INSTALL_EXEC) -D $(BUILD_DIR)/hat/ext4fixup $(HOST_DIR)/bin/
		$(INSTALL_EXEC) -D $(BUILD_DIR)/hat/img2simg $(HOST_DIR)/bin/
		$(INSTALL_EXEC) -D $(BUILD_DIR)/hat/make_ext4fs $(HOST_DIR)/bin/
		$(INSTALL_EXEC) -D $(BUILD_DIR)/hat/simg2img $(HOST_DIR)/bin/
		$(INSTALL_EXEC) -D $(BUILD_DIR)/hat/simg2simg $(HOST_DIR)/bin/
	$(REMOVE)/hat
	$(TOUCH)
