#
# curlftpfs
#
CURLFTPFS_VER    = 0.9.2
CURLFTPFS_DIR    = curlftpfs-$(CURLFTPFS_VER)
CURLFTPFS_SOURCE = curlftpfs-$(CURLFTPFS_VER).tar.gz
CURLFTPFS_SITE   = https://sourceforge.net/projects/curlftpfs/files/latest/download
CURLFTPFS_DEPS   = bootstrap libcurl libfuse glib2

$(D)/curlftpfs:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(PKG_CHDIR); \
		export ac_cv_func_malloc_0_nonnull=yes; \
		export ac_cv_func_realloc_0_nonnull=yes; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
