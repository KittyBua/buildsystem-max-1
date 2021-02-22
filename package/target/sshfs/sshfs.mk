#
# sshfs
#
SSHFS_VER    = 2.9
SSHFS_DIR    = sshfs-$(SSHFS_VER)
SSHFS_SOURCE = sshfs-$(SSHFS_VER).tar.gz
SSHFS_SITE   = https://github.com/libfuse/sshfs/releases/download/sshfs-$(SSHFS_VER)
SSHFS_DEPS   = bootstrap glib2 libfuse

$(D)/sshfs:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
