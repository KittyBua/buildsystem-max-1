################################################################################
#
# minisatip
#
################################################################################

MINISATIP_VERSION = git
MINISATIP_DIR     = minisatip.git
MINISATIP_SOURCE  = minisatip.git
MINISATIP_SITE    = https://github.com/catalinii
MINISATIP_DEPENDS = bootstrap libdvbcsa openssl

MINISATIP_CONF_ENV = \
	CFLAGS+=" -ldl"

MINISATIP_CONF_OPTS = \
	--enable-static \
	--disable-netcv

define MINISATIP_INSTALL_INIT_SYSV
	$(INSTALL_DATA) $(PKG_FILES_DIR)/minisatip $(TARGET_DIR)/etc/default/minisatip
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/minisatip.init $(TARGET_DIR)/etc/init.d/minisatip
	$(UPDATE-RC.D) minisatip defaults 75 25
endef

define MINISATIP_INSTALL_FILES
	$(INSTALL_EXEC) -D $(PKG_BUILD_DIR)/minisatip $(TARGET_BIN_DIR)
	$(INSTALL) -d $(TARGET_SHARE_DIR)/minisatip
	$(INSTALL_COPY) $(PKG_BUILD_DIR)/html $(TARGET_SHARE_DIR)/minisatip
endef
MINISATIP_POST_FOLLOWUP_HOOKS += MINISATIP_INSTALL_FILES

$(D)/minisatip:
	$(call PREPARE)
	$(call TARGET_CONFIGURE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(MAKE)
	$(call TARGET_FOLLOWUP)
