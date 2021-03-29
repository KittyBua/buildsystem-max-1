#
# rarfs
#
RARFS_VERSION = 0.1.1
RARFS_DIR     = rarfs-$(RARFS_VERSION)
RARFS_SOURCE  = rarfs-$(RARFS_VERSION).tar.gz
RARFS_SITE    = https://sourceforge.net/projects/rarfs/files/rarfs/$(RARFS_VERSION)
RARFS_DEPENDS = bootstrap libfuse

RARFS_CONF_OPTS = \
	CFLAGS="$(TARGET_CFLAGS) -D_FILE_OFFSET_BITS=64" \
	--disable-option-checking \
	--includedir=/usr/include/fuse

rarfs:
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
