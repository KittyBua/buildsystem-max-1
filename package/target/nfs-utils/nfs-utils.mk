#
# nfs-utils
#
NFS_UTILS_VER    = 2.5.2
NFS_UTILS_DIR    = nfs-utils-$(NFS_UTILS_VER)
NFS_UTILS_SOURCE = nfs-utils-$(NFS_UTILS_VER).tar.bz2
NFS_UTILS_SITE   = https://sourceforge.net/projects/nfs/files/nfs-utils/$(NFS_UTILS_VER)

NFS_UTILS_PATCH = \
	0001-disabled-ip6-support.patch \
	0002-Makefile.am-fix-undefined-function-for-libnsm.a.patch

NFS_UTILS_CONF_OPTS = \
	--disable-gss \
	--disable-nfsdcltrack \
	--disable-nfsv4 \
	--disable-nfsv41 \
	--enable-mount \
	--enable-libmount-mount \
	--without-tcp-wrappers \
	--without-systemd \
	--with-statduser=rpcuser \
	--with-statdpath=/var/lib/nfs/statd

NFS_UTILS_CONF_OPTS += \
	$(if $(filter $(BOXMODEL),vuduo),--disable-ipv6,--enable-ipv6)

$(D)/nfs-utils: bootstrap rpcbind e2fsprogs
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		export knfsd_cv_bsd_signals=no; \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(INSTALL_DATA) $(PKG_FILES_DIR)/exports $(TARGET_DIR)/etc/exports
	$(INSTALL_DATA) $(PKG_FILES_DIR)/idmapd.conf $(TARGET_DIR)/etc/idmapd.conf
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/nfscommon.init $(TARGET_DIR)/etc/init.d/nfscommon
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/nfsserver.init $(TARGET_DIR)/etc/init.d/nfsserver
	$(UPDATE-RC.D) nfsserver defaults 13
	$(UPDATE-RC.D) nfscommon defaults 19 11
	chmod 0755 $(TARGET_DIR)/sbin/mount.nfs
	rm -f $(addprefix $(TARGET_DIR)/sbin/,mount.nfs4 umount.nfs umount.nfs4)
	rm -f $(addprefix $(TARGET_DIR)/usr/sbin/,mountstats nfsiostat)
	$(PKG_REMOVE)
	$(TOUCH)
