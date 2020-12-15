#
# rarfs
#
RARFS_VER    = 0.1.1
RARFS_DIR    = rarfs-$(RARFS_VER)
RARFS_SOURCE = rarfs-$(RARFS_VER).tar.gz
RARFS_SITE   = https://sourceforge.net/projects/rarfs/files/rarfs/$(RARFS_VER)

RARFS_CONF_OPTS = \
	CFLAGS="$(TARGET_CFLAGS) -D_FILE_OFFSET_BITS=64" \
	--disable-option-checking \
	--includedir=/usr/include/fuse

$(D)/rarfs: bootstrap libfuse
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
