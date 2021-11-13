#
# autofs
#
AUTOFS_VERSION = 5.1.8
AUTOFS_DIR     = autofs-$(AUTOFS_VERSION)
AUTOFS_SOURCE  = autofs-$(AUTOFS_VERSION).tar.xz
AUTOFS_SITE    = https://www.kernel.org/pub/linux/daemons/autofs/v5
AUTOFS_DEPENDS = bootstrap libtirpc e2fsprogs openssl libxml2

AUTOFS_AUTORECONF = YES

AUTOFS_CONF_ENV = \
	ac_cv_path_RANLIB=$(TARGET_RANLIB); \
	ac_cv_path_E2FSCK=/sbin/fsck \
	ac_cv_path_E3FSCK=no \
	ac_cv_path_E4FSCK=no \
	ac_cv_path_KRB5_CONFIG=no \
	ac_cv_path_MODPROBE=/sbin/modprobe \
	ac_cv_path_MOUNT=/bin/mount \
	ac_cv_path_MOUNT_NFS=/usr/sbin/mount.nfs \
	ac_cv_path_UMOUNT=/bin/umount \
	ac_cv_linux_procfs=yes

AUTOFS_CONF_OPTS = \
	--disable-mount-locking \
	--with-openldap=no \
	--with-sasl=no \
	--enable-ignore-busy \
	--with-path=$(PATH) \
	--with-libtirpc \
	--with-hesiod=no \
	--with-confdir=$(sysconfdir) \
	--with-mapdir=$(sysconfdir) \
	--with-fifodir=/var/run \
	--with-flagdir=/var/run

$(D)/autofs:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE) SUBDIRS="lib daemon modules" DONTSTRIP=1; \
		$(MAKE) SUBDIRS="lib daemon modules" install DESTDIR=$(TARGET_DIR)
	$(INSTALL_DATA) $(PKG_FILES_DIR)/auto.master $(TARGET_DIR)/etc/auto.master
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/auto.net $(TARGET_DIR)/etc/auto.net
	$(INSTALL_DATA) $(PKG_FILES_DIR)/auto.network $(TARGET_DIR)/etc/auto.network
	$(INSTALL_DATA) $(PKG_FILES_DIR)/autofs.conf $(TARGET_DIR)/etc/autofs.conf
	$(INSTALL_DATA) $(PKG_FILES_DIR)/autofs $(TARGET_DIR)/etc/default/autofs
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/autofs.init $(TARGET_DIR)/etc/init.d/autofs
	$(INSTALL_DATA) $(PKG_FILES_DIR)/volatiles.99_autofs $(TARGET_DIR)/etc/default/volatiles/99_autofs
	$(UPDATE-RC.D) autofs defaults 17
	$(REMOVE)
	rm -f $(addprefix $(TARGET_DIR)/etc/,autofs_ldap_auth.conf)
	$(TOUCH)
