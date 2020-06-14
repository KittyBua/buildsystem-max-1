#
# wpa-supplicant
#
WPA_SUPPLICANT_VER    = 2.7
WPA_SUPPLICANT_DIR    = wpa_supplicant-$(WPA_SUPPLICANT_VER)
WPA_SUPPLICANT_SOURCE = wpa_supplicant-$(WPA_SUPPLICANT_VER).tar.gz
WPA_SUPPLICANT_URL    = https://w1.fi/releases

$(D)/wpa-supplicant: bootstrap libnl openssl wireless-tools
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR)/wpa_supplicant; \
		cp -f defconfig .config; \
		sed -i 's/#CONFIG_DRIVER_RALINK=y/CONFIG_DRIVER_RALINK=y/' .config; \
		sed -i 's/#CONFIG_IEEE80211W=y/CONFIG_IEEE80211W=y/' .config; \
		sed -i 's/#CONFIG_OS=unix/CONFIG_OS=unix/' .config; \
		sed -i 's/#CONFIG_TLS=openssl/CONFIG_TLS=openssl/' .config; \
		export CFLAGS="-pipe -Os -Wall -g0 -I$(TARGET_INCLUDE_DIR) -I$(TARGET_INCLUDE_DIR)/libnl3/"; \
		export CPPFLAGS="-I$(TARGET_INCLUDE_DIR)"; \
		export LIBS="-L$(TARGET_LIB_DIR) -Wl,-rpath-link,$(TARGET_LIB_DIR)"; \
		export LDFLAGS="-L$(TARGET_LIB_DIR)"; \
		export DESTDIR=$(TARGET_DIR); \
		$(MAKE) CC=$(TARGET_CC); \
		$(MAKE) install LIBDIR=/usr/lib BINDIR=/usr/sbin DESTDIR=$(TARGET_DIR)
	mkdir -p $(TARGET_DIR)/etc/{network,wpa_supplicant}
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/post-wlan0.sh $(TARGET_DIR)/etc/network
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/pre-wlan0.sh $(TARGET_DIR)/etc/network
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/action_wpa.sh $(TARGET_DIR)/etc/wpa_supplicant
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/functions.sh $(TARGET_DIR)/etc/wpa_supplicant
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/ifupdown.sh $(TARGET_DIR)/etc/wpa_supplicant
	$(INSTALL_DATA) $(PKG_FILES_DIR)/volatiles.99_wpa_supplicant $(TARGET_DIR)/etc/default/volatiles/99_wpa_supplicant
	ln -sf ../../wpa_supplicant/ifupdown.sh $(TARGET_DIR)/etc/network/if-down.d/wpa-supplicant
	ln -sf ../../wpa_supplicant/ifupdown.sh $(TARGET_DIR)/etc/network/if-post-down.d/wpa-supplicant
	ln -sf ../../wpa_supplicant/ifupdown.sh $(TARGET_DIR)/etc/network/if-pre-up.d/wpa-supplicant
	ln -sf ../../wpa_supplicant/ifupdown.sh $(TARGET_DIR)/etc/network/if-up.d/wpa-supplicant
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
