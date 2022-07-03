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

MINISATIP_MAKE_ENV = \
	$(TARGET_CONFIGURE_ENV)

define MINISATIP_INSTALL_INIT_SYSV
	$(INSTALL_DATA) $(PKG_FILES_DIR)/minisatip $(TARGET_DIR)/etc/default/minisatip
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/minisatip.init $(TARGET_DIR)/etc/init.d/minisatip
	$(UPDATE-RC.D) minisatip defaults 75 25
endef

define MINISATIP_INSTALL
	$(INSTALL_EXEC) -D $(PKG_BUILD_DIR)/minisatip $(TARGET_BIN_DIR)
	$(INSTALL) -d $(TARGET_SHARE_DIR)/minisatip
	$(INSTALL_COPY) $(PKG_BUILD_DIR)/html $(TARGET_SHARE_DIR)/minisatip
endef
MINISATIP_POST_FOLLOWUP_HOOKS += MINISATIP_INSTALL

$(D)/minisatip:
	$(call autotools-package,$(PKG_NO_INSTALL))
