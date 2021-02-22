#
# wlan-qcom-firmware osmio4k | osmio4kplus
#
WLAN_QCOM_FIRMWARE_VER    = qca6174
WLAN_QCOM_FIRMWARE_DIR    = firmware-$(WLAN_QCOM_FIRMWARE_VER)
WLAN_QCOM_FIRMWARE_SOURCE = firmware-$(WLAN_QCOM_FIRMWARE_VER).zip
WLAN_QCOM_FIRMWARE_SITE   = http://source.mynonpublic.com/edision
WLAN_QCOM_FIRMWARE_DEPS   = bootstrap

$(D)/wlan-qcom-firmware:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(PKG_BUILD_DIR))
	$(INSTALL) -d $(TARGET_FIRMWARE_DIR)/ath10k/QCA6174/hw3.0
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/board.bin $(TARGET_FIRMWARE_DIR)/ath10k/QCA6174/hw3.0/board.bin
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/firmware-4.bin $(TARGET_FIRMWARE_DIR)/ath10k/QCA6174/hw3.0/firmware-4.bin
	$(INSTALL) -d $(TARGET_FIRMWARE_DIR)/wlan
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/bdwlan30.bin $(TARGET_FIRMWARE_DIR)/bdwlan30.bin
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/otp30.bin $(TARGET_FIRMWARE_DIR)/otp30.bin
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/qwlan30.bin $(TARGET_FIRMWARE_DIR)/qwlan30.bin
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/utf30.bin $(TARGET_FIRMWARE_DIR)/utf30.bin
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/wlan/cfg.dat $(TARGET_FIRMWARE_DIR)/wlan/cfg.dat
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/wlan/qcom_cfg.ini $(TARGET_FIRMWARE_DIR)/wlan/qcom_cfg.ini
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/btfw32.tlv $(TARGET_FIRMWARE_DIR)/btfw32.tlv
	$(REMOVE)
	$(TOUCH)
