#
# rarfs
#
RARFS_VER    = 0.1.1
RARFS_DIR    = rarfs-$(RARFS_VER)
RARFS_SOURCE = rarfs-$(RARFS_VER).tar.gz
RARFS_SITE   = https://sourceforge.net/projects/rarfs/files/rarfs/$(RARFS_VER)
RARFS_DEPS   = bootstrap libfuse

RARFS_CONF_OPTS = \
	CFLAGS="$(TARGET_CFLAGS) -D_FILE_OFFSET_BITS=64" \
	--disable-option-checking \
	--includedir=/usr/include/fuse

$(D)/rarfs:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
