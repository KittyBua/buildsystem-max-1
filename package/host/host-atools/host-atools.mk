#
# host-atools
#
HOST_ATOOLS_VER = 1.0
HOST_ATOOLS_DIR = hat

HOST_HAT_CORE_REV          = 2314b11
HOST_HAT_CORE_SOURCE       = hat-core-$(HOST_HAT_CORE_REV).tar.bz2

HOST_HAT_EXTRAS_REV        = 3ecbe8d
HOST_HAT_EXTRAS_SOURCE     = hat-extras-$(HOST_HAT_EXTRAS_REV).tar.bz2

HOST_HAT_LIBSELINUX_REV    = 07e9e13
HOST_HAT_LIBSELINUX_SOURCE = hat-libselinux-$(HOST_HAT_LIBSELINUX_REV).tar.bz2

HOST_HAT_MIRROR_SITE       = https://android.googlesource.com/platform

$(DL_DIR)/$(HOST_HAT_CORE_SOURCE):
	$(GET-GIT-ARCHIVE) $(HOST_HAT_MIRROR_SITE)/system/core $(HOST_HAT_CORE_REV) $(notdir $@) $(DL_DIR)

$(DL_DIR)/$(HOST_HAT_EXTRAS_SOURCE):
	$(GET-GIT-ARCHIVE) $(HOST_HAT_MIRROR_SITE)/system/extras $(HOST_HAT_EXTRAS_REV) $(notdir $@) $(DL_DIR)

$(DL_DIR)/$(HOST_HAT_LIBSELINUX_SOURCE):
	$(GET-GIT-ARCHIVE) $(HOST_HAT_MIRROR_SITE)/external/libselinux $(HOST_HAT_LIBSELINUX_REV) $(notdir $@) $(DL_DIR)

$(D)/host-atools: $(DL_DIR)/$(HOST_HAT_CORE_SOURCE) $(DL_DIR)/$(HOST_HAT_EXTRAS_SOURCE) $(DL_DIR)/$(HOST_HAT_LIBSELINUX_SOURCE)
	$(START_BUILD)
	$(PKG_REMOVE)
	$(MKDIR)/hat/system/core
	$(SILENT)tar --strip 1 -C $(BUILD_DIR)/hat/system/core -xf $(DL_DIR)/$(HOST_HAT_CORE_SOURCE)
	$(MKDIR)/hat/system/extras
	$(SILENT)tar --strip 1 -C $(BUILD_DIR)/hat/system/extras -xf $(DL_DIR)/$(HOST_HAT_EXTRAS_SOURCE)
	$(MKDIR)/hat/external/libselinux
	$(SILENT)tar --strip 1 -C $(BUILD_DIR)/hat/external/libselinux -xf $(DL_DIR)/$(HOST_HAT_LIBSELINUX_SOURCE)
	$(INSTALL_DATA) $(PKG_FILES_DIR)/ext4_utils.helper $(BUILD_DIR)/hat/ext4_utils.mk
	$(PKG_CHDIR); \
		$(MAKE) --file=ext4_utils.mk SRCDIR=$(BUILD_DIR)/hat
		$(INSTALL_EXEC) -D $(BUILD_DIR)/hat/ext2simg $(HOST_DIR)/bin/
		$(INSTALL_EXEC) -D $(BUILD_DIR)/hat/ext4fixup $(HOST_DIR)/bin/
		$(INSTALL_EXEC) -D $(BUILD_DIR)/hat/img2simg $(HOST_DIR)/bin/
		$(INSTALL_EXEC) -D $(BUILD_DIR)/hat/make_ext4fs $(HOST_DIR)/bin/
		$(INSTALL_EXEC) -D $(BUILD_DIR)/hat/simg2img $(HOST_DIR)/bin/
		$(INSTALL_EXEC) -D $(BUILD_DIR)/hat/simg2simg $(HOST_DIR)/bin/
	$(PKG_REMOVE)
	$(TOUCH)
