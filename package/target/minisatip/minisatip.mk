#
# minisatip
#
MINISATIP_VERSION = git
MINISATIP_DIR     = minisatip.git
MINISATIP_SOURCE  = minisatip.git
MINISATIP_SITE    = https://github.com/catalinii
MINISATIP_DEPENDS = bootstrap libdvbcsa openssl dvb-apps

MINISATIP_CONF_OPTS = \
	--enable-static \
	--enable-enigma \
	--disable-netcv

$(D)/minisatip:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE) EXTRA_CFLAGS="-pipe -Os -Wall -g0 -I$(TARGET_DIR)/usr/include"; \
	$(INSTALL_EXEC) -D $(PKG_BUILD_DIR)/minisatip $(TARGET_DIR)/usr/bin
	$(INSTALL) -d $(TARGET_SHARE_DIR)/minisatip
	$(INSTALL_COPY) $(PKG_BUILD_DIR)/html $(TARGET_SHARE_DIR)/minisatip
	$(INSTALL_DATA) $(PKG_FILES_DIR)/minisatip $(TARGET_DIR)/etc/default/minisatip
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/minisatip.init $(TARGET_DIR)/etc/init.d/minisatip
	$(REMOVE)
	$(TOUCH)