#
# host-e2fsprogs
#
HOST_E2FSPROGS_VER    = 1.45.6
HOST_E2FSPROGS_DIR    = e2fsprogs-$(HOST_E2FSPROGS_VER)
HOST_E2FSPROGS_SOURCE = e2fsprogs-$(HOST_E2FSPROGS_VER).tar.gz
HOST_E2FSPROGS_URL    = https://sourceforge.net/projects/e2fsprogs/files/e2fsprogs/v$(HOST_E2FSPROGS_VER)

$(D)/host-e2fsprogs: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		export PKG_CONFIG=/usr/bin/pkg-config; \
		export PKG_CONFIG_PATH=$(HOST_DIR)/lib/pkgconfig; \
		./configure $(SILENT_OPT); \
		$(MAKE)
	$(INSTALL_EXEC) -D $(BUILD_DIR)/$(HOST_E2FSPROGS_DIR)/resize/resize2fs $(HOST_DIR)/bin/
	$(INSTALL_EXEC) -D $(BUILD_DIR)/$(HOST_E2FSPROGS_DIR)/misc/mke2fs $(HOST_DIR)/bin/
	ln -sf mke2fs $(HOST_DIR)/bin/mkfs.ext2
	ln -sf mke2fs $(HOST_DIR)/bin/mkfs.ext3
	ln -sf mke2fs $(HOST_DIR)/bin/mkfs.ext4
	ln -sf mke2fs $(HOST_DIR)/bin/mkfs.ext4dev
	$(INSTALL_EXEC) -D $(BUILD_DIR)/$(HOST_E2FSPROGS_DIR)/e2fsck/e2fsck $(HOST_DIR)/bin/
	ln -sf e2fsck $(HOST_DIR)/bin/fsck.ext2
	ln -sf e2fsck $(HOST_DIR)/bin/fsck.ext3
	ln -sf e2fsck $(HOST_DIR)/bin/fsck.ext4
	ln -sf e2fsck $(HOST_DIR)/bin/fsck.ext4dev
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
