#
# wlan-qcom-firmware
#
OSMIO4K_WLAN_QCOM_FIRMWARE_VER    = qca6174
OSMIO4K_WLAN_QCOM_FIRMWARE_DIR    = firmware-$(OSMIO4K_WLAN_QCOM_FIRMWARE_VER)
OSMIO4K_WLAN_QCOM_FIRMWARE_SOURCE = firmware-$(OSMIO4K_WLAN_QCOM_FIRMWARE_VER).zip
OSMIO4K_WLAN_QCOM_FIRMWARE_URL    = http://source.mynonpublic.com/edision

$(D)/osmio4k-wlan-qcom-firmware: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	unzip -o $(SILENT_Q) $(DL_DIR)/$(PKG_SOURCE) -d $(PKG_BUILD_DIR)
	$(INSTALL) -d $(TARGET_DIR)/lib/firmware/ath10k/QCA6174/hw3.0
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/board.bin $(TARGET_DIR)/lib/firmware/ath10k/QCA6174/hw3.0/board.bin
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/firmware-4.bin $(TARGET_DIR)/lib/firmware/ath10k/QCA6174/hw3.0/firmware-4.bin
	$(INSTALL) -d $(TARGET_DIR)/lib/firmware/wlan
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/bdwlan30.bin $(TARGET_DIR)/lib/firmware/bdwlan30.bin
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/otp30.bin $(TARGET_DIR)/lib/firmware/otp30.bin
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/qwlan30.bin $(TARGET_DIR)/lib/firmware/qwlan30.bin
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/utf30.bin $(TARGET_DIR)/lib/firmware/utf30.bin
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/wlan/cfg.dat $(TARGET_DIR)/lib/firmware/wlan/cfg.dat
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/wlan/qcom_cfg.ini $(TARGET_DIR)/lib/firmware/wlan/qcom_cfg.ini
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/btfw32.tlv $(TARGET_DIR)/lib/firmware/btfw32.tlv
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
