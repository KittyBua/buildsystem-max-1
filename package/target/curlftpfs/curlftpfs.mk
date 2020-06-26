#
# curlftpfs
#
CURLFTPFS_VER    = 0.9.2
CURLFTPFS_DIR    = curlftpfs-$(CURLFTPFS_VER)
CURLFTPFS_SOURCE = curlftpfs-$(CURLFTPFS_VER).tar.gz
CURLFTPFS_SITE   = https://sourceforge.net/projects/curlftpfs/files/latest/download

CURLFTPFS_PATCH  = \
	0001-curlftpfs.patch

$(D)/curlftpfs: bootstrap libcurl libfuse glib2
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		export ac_cv_func_malloc_0_nonnull=yes; \
		export ac_cv_func_realloc_0_nonnull=yes; \
		$(CONFIGURE) \
			--target=$(TARGET) \
			--prefix=/usr \
			--mandir=/.remove \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
