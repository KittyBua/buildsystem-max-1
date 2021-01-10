#
# wpa-supplicant
#
WPA_SUPPLICANT_VER    = 2.7
WPA_SUPPLICANT_DIR    = wpa_supplicant-$(WPA_SUPPLICANT_VER)
WPA_SUPPLICANT_SOURCE = wpa_supplicant-$(WPA_SUPPLICANT_VER).tar.gz
WPA_SUPPLICANT_SITE   = https://w1.fi/releases

$(D)/wpa-supplicant: bootstrap libnl openssl wireless-tools
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(INSTALL_DATA) $(PKG_FILES_DIR)/wpa_supplicant.config wpa_supplicant/.config; \
		$(BUILD_ENV) \
		$(MAKE) -C wpa_supplicant; \
		$(MAKE) -C wpa_supplicant install LIBDIR=$(base_libdir) BINDIR=$(sbindir) DESTDIR=$(TARGET_DIR)
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/post-wlan0.sh $(TARGET_DIR)/etc/network
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/pre-wlan0.sh $(TARGET_DIR)/etc/network
	$(INSTALL_DATA) $(PKG_FILES_DIR)/volatiles.99_wpa_supplicant $(TARGET_DIR)/etc/default/volatiles/99_wpa_supplicant
	$(PKG_REMOVE)
	$(TOUCH)
