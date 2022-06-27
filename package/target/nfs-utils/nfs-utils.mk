################################################################################
#
# nfs-utils
#
################################################################################

NFS_UTILS_VERSION = 2.6.1
NFS_UTILS_DIR     = nfs-utils-$(NFS_UTILS_VERSION)
NFS_UTILS_SOURCE  = nfs-utils-$(NFS_UTILS_VERSION).tar.bz2
NFS_UTILS_SITE    = https://sourceforge.net/projects/nfs/files/nfs-utils/$(NFS_UTILS_VERSION)
NFS_UTILS_DEPENDS = bootstrap libtirpc rpcbind e2fsprogs

NFS_UTILS_AUTORECONF = YES

NFS_UTILS_CONF_ENV = \
	knfsd_cv_bsd_signals=no

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

define NFS_UTILS_INSTALL_INIT_SYSV
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/nfscommon.init $(TARGET_DIR)/etc/init.d/nfscommon
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/nfsserver.init $(TARGET_DIR)/etc/init.d/nfsserver
	$(UPDATE-RC.D) nfsserver defaults 13
	$(UPDATE-RC.D) nfscommon defaults 19 11
endef

define NFS_UTILS_INSTALL_FILES
	$(INSTALL_DATA) $(PKG_FILES_DIR)/exports $(TARGET_DIR)/etc/exports
	$(INSTALL_DATA) $(PKG_FILES_DIR)/idmapd.conf $(TARGET_DIR)/etc/idmapd.conf
	chmod 0755 $(TARGET_BASE_SBIN_DIR)/mount.nfs
endef
NFS_UTILS_POST_INSTALL_HOOKS += NFS_UTILS_INSTALL_FILES

NFS_UTILS_CONF_OPTS += \
	$(if $(filter $(BOXMODEL),vuduo),--disable-ipv6,--enable-ipv6)

define NFS_UTILS_CLEANUP_TARGET
	rm -f $(addprefix $(TARGET_BASE_SBIN_DIR)/,mount.nfs4 umount.nfs umount.nfs4)
	rm -f $(addprefix $(TARGET_SBIN_DIR)/,mountstats nfsiostat)
endef
NFS_UTILS_CLEANUP_TARGET_HOOKS += NFS_UTILS_CLEANUP_TARGET

$(D)/nfs-utils:
	$(call make-package)
