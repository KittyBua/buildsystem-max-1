#
# autofs
#
AUTOFS_VER    = 5.1.6
AUTOFS_DIR    = autofs-$(AUTOFS_VER)
AUTOFS_SOURCE = autofs-$(AUTOFS_VER).tar.xz
AUTOFS_SITE   = https://www.kernel.org/pub/linux/daemons/autofs/v5

AUTOFS_CONF_OPTS = \
	--disable-mount-locking \
	--with-openldap=no \
	--with-sasl=no \
	--enable-ignore-busy \
	--with-path=$(PATH) \
	--with-libtirpc \
	--with-hesiod=no \
	--with-confdir=/etc \
	--with-mapdir=/etc \
	--with-fifodir=/var/run \
	--with-flagdir=/var/run

$(D)/autofs: bootstrap libtirpc e2fsprogs openssl libxml2
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		export ac_cv_path_KRB5_CONFIG=no; \
		export ac_cv_linux_procfs=yes; \
		export ac_cv_path_RANLIB=$(TARGET_RANLIB); \
		autoreconf -fi; \
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
	rm -f $(addprefix $(TARGET_DIR)/etc/,autofs_ldap_auth.conf)
	$(PKG_REMOVE)
	$(TOUCH)
