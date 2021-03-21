#
# xupnpd
#
XUPNPD_VERSION = git
XUPNPD_DIR     = xupnpd.git
XUPNPD_SOURCE  = xupnpd.git
XUPNPD_SITE    = https://github.com/clark15b
XUPNPD_DEPENDS = bootstrap lua openssl neutrino-plugins

XUPNPD_CHECKOUT = 25d6d44

$(D)/xupnpd:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(MAKE) -C src embedded TARGET=$(GNU_TARGET_NAME) PKG_CONFIG=$(PKG_CONFIG) LUAFLAGS="$(TARGET_LDFLAGS) -I$(TARGET_INCLUDE_DIR)"; \
		$(MAKE) -C src install DESTDIR=$(TARGET_DIR)
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/xupnpd.init $(TARGET_DIR)/etc/init.d/xupnpd
	mkdir -p $(TARGET_SHARE_DIR)/xupnpd/{config,playlists}
	rm $(TARGET_SHARE_DIR)/xupnpd/plugins/staff/xupnpd_18plus.lua
	$(INSTALL_DATA) -D $(SOURCE_DIR)/$(NEUTRINO_PLUGINS_DIR)/scripts-lua/xupnpd/xupnpd_18plus.lua $(TARGET_SHARE_DIR)/xupnpd/plugins/
	$(INSTALL_DATA) -D $(SOURCE_DIR)/$(NEUTRINO_PLUGINS_DIR)/scripts-lua/xupnpd/xupnpd_cczwei.lua $(TARGET_SHARE_DIR)/xupnpd/plugins/
	$(INSTALL_DATA) -D $(SOURCE_DIR)/$(NEUTRINO_PLUGINS_DIR)/scripts-lua/xupnpd/xupnpd_neutrino.lua $(TARGET_SHARE_DIR)/xupnpd/plugins/
	$(INSTALL_DATA) -D $(SOURCE_DIR)/$(NEUTRINO_PLUGINS_DIR)/scripts-lua/xupnpd/xupnpd_vimeo.lua $(TARGET_SHARE_DIR)/xupnpd/plugins/
	$(INSTALL_DATA) -D $(SOURCE_DIR)/$(NEUTRINO_PLUGINS_DIR)/scripts-lua/xupnpd/xupnpd_youtube.lua $(TARGET_SHARE_DIR)/xupnpd/plugins/
	$(UPDATE-RC.D) xupnpd defaults 75 25
	$(REMOVE)
	$(TOUCH)
