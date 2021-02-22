#
# vsftpd
#
VSFTPD_VER    = 3.0.3
VSFTPD_DIR    = vsftpd-$(VSFTPD_VER)
VSFTPD_SOURCE = vsftpd-$(VSFTPD_VER).tar.gz
VSFTPD_SITE   = https://security.appspot.com/downloads
VSFTPD_DEPS   = bootstrap openssl

define VSFTPD_POST_PATCH
	$(SED) 's/.*VSF_BUILD_PAM/#undef VSF_BUILD_PAM/' $(PKG_BUILD_DIR)/builddefs.h
	$(SED) 's/.*VSF_BUILD_SSL/#define VSF_BUILD_SSL/' $(PKG_BUILD_DIR)/builddefs.h
endef
VSFTPD_POST_PATCH_HOOKS = VSFTPD_POST_PATCH

$(D)/vsftpd:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(MAKE) clean; \
		$(MAKE) $(TARGET_CONFIGURE_ENV) LIBS="-lcrypt -lcrypto -lssl"; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(INSTALL_DATA) $(PKG_FILES_DIR)/vsftpd $(TARGET_DIR)/etc/default/vsftpd
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vsftpd.init $(TARGET_DIR)/etc/init.d/vsftpd
	$(INSTALL_DATA) $(PKG_FILES_DIR)/vsftpd.conf $(TARGET_DIR)/etc/vsftpd.conf
	$(INSTALL_DATA) $(PKG_FILES_DIR)/volatiles.99_vsftpd $(TARGET_DIR)/etc/default/volatiles/99_vsftpd
#	$(UPDATE-RC.D) vsftpd start 80 2 3 4 5 . stop 80 0 1 6 .
	$(UPDATE-RC.D) vsftpd start 20 2 3 4 5 . stop 20 0 1 6 .
	$(REMOVE)
	$(TOUCH)
