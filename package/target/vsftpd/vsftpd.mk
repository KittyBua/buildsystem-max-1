#
# vsftpd
#
VSFTPD_VER    = 3.0.3
VSFTPD_DIR    = vsftpd-$(VSFTPD_VER)
VSFTPD_SOURCE = vsftpd-$(VSFTPD_VER).tar.gz
VSFTPD_SITE   = https://security.appspot.com/downloads

VSFTPD_PATCH  = \
	0001-vsftpd.patch \
	0002-vsftpd-makefile-destdir.patch \
	0003-vsftpd-disable-capabilities.patch \
	0004-vsftpd-fixchroot.patch \
	0005-vsftpd-login-blank-password.patch

$(D)/vsftpd: bootstrap openssl
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		sed -i -e 's/.*VSF_BUILD_PAM/#undef VSF_BUILD_PAM/' builddefs.h; \
		sed -i -e 's/.*VSF_BUILD_SSL/#define VSF_BUILD_SSL/' builddefs.h; \
		$(MAKE) clean; \
		$(MAKE) $(BUILD_ENV) LIBS="-lcrypt -lcrypto -lssl"; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(INSTALL_DATA) $(PKG_FILES_DIR)/vsftpd $(TARGET_DIR)/etc/default/vsftpd
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vsftpd.init $(TARGET_DIR)/etc/init.d/vsftpd
	$(INSTALL_DATA) $(PKG_FILES_DIR)/vsftpd.conf $(TARGET_DIR)/etc/vsftpd.conf
	$(INSTALL_DATA) $(PKG_FILES_DIR)/volatiles.99_vsftpd $(TARGET_DIR)/etc/default/volatiles/99_vsftpd
#	$(UPDATE-RC.D) vsftpd start 80 2 3 4 5 . stop 80 0 1 6 .
	$(UPDATE-RC.D) vsftpd start 20 2 3 4 5 . stop 20 0 1 6 .
	$(PKG_REMOVE)
	$(TOUCH)
