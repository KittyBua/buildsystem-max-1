#
# ntfs-3g
#
NTFS_3G_VERSION = 2017.3.23
NTFS_3G_DIR     = ntfs-3g_ntfsprogs-$(NTFS_3G_VERSION)
NTFS_3G_SOURCE  = ntfs-3g_ntfsprogs-$(NTFS_3G_VERSION).tgz
NTFS_3G_SITE    = https://tuxera.com/opensource
NTFS_3G_DEPENDS = bootstrap libfuse

NTFS_3G_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--disable-ntfsprogs \
	--disable-ldconfig \
	--disable-library \
	--with-fuse=external

$(D)/ntfs-3g:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	ln -sf mount.ntfs-3g $(TARGET_DIR)/sbin/mount.ntfs
	$(REMOVE)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,lowntfs-3g ntfs-3g.probe)
	rm -f $(addprefix $(TARGET_DIR)/sbin/,mount.lowntfs-3g)
	$(TOUCH)
