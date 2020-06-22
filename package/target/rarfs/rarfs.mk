#
# rarfs
#
RARFS_VER    = 0.1.1
RARFS_DIR    = rarfs-$(RARFS_VER)
RARFS_SOURCE = rarfs-$(RARFS_VER).tar.gz
RARFS_SITE   = https://sourceforge.net/projects/rarfs/files/rarfs/$(RARFS_VER)

$(D)/rarfs: bootstrap libfuse
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			CFLAGS="$(TARGET_CFLAGS) -D_FILE_OFFSET_BITS=64" \
			--prefix=/usr \
			--disable-option-checking \
			--includedir=/usr/include/fuse \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
