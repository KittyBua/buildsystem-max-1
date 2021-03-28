#
# wpa-supplicant
#
WPA_SUPPLICANT_VERSION = 2.9
WPA_SUPPLICANT_DIR     = wpa_supplicant-$(WPA_SUPPLICANT_VERSION)
WPA_SUPPLICANT_SOURCE  = wpa_supplicant-$(WPA_SUPPLICANT_VERSION).tar.gz
WPA_SUPPLICANT_SITE    = https://w1.fi/releases
WPA_SUPPLICANT_DEPENDS = bootstrap libnl openssl wireless-tools

$(D)/wpa-supplicant:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(INSTALL_DATA) $(PKG_FILES_DIR)/wpa_supplicant.config wpa_supplicant/.config; \
		$(TARGET_CONFIGURE_OPTS) \
		$(MAKE) -C wpa_supplicant; \
		$(MAKE) -C wpa_supplicant install LIBDIR=$(libdir) BINDIR=$(sbindir) DESTDIR=$(TARGET_DIR)
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/post-wlan0.sh $(TARGET_DIR)/etc/network
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/pre-wlan0.sh $(TARGET_DIR)/etc/network
	$(INSTALL_DATA) $(PKG_FILES_DIR)/volatiles.99_wpa_supplicant $(TARGET_DIR)/etc/default/volatiles/99_wpa_supplicant
	$(INSTALL_DATA) $(PKG_FILES_DIR)/wpa_supplicant.conf $(TARGET_DIR)/etc/wpa_supplicant.conf
	$(REMOVE)
	$(TOUCH)
