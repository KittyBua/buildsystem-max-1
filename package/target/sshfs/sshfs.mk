#
# sshfs
#
SSHFS_VERSION = 2.9
SSHFS_DIR     = sshfs-$(SSHFS_VERSION)
SSHFS_SOURCE  = sshfs-$(SSHFS_VERSION).tar.gz
SSHFS_SITE    = https://github.com/libfuse/sshfs/releases/download/sshfs-$(SSHFS_VERSION)
SSHFS_DEPENDS = bootstrap glib2 libfuse

$(D)/sshfs:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
