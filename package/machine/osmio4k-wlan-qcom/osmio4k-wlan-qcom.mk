#
# wlan-qcom osmio4k | osmio4kplus
#
OSMIO4K_WLAN_QCOM_VER    = 4.5.25.32
OSMIO4K_WLAN_QCOM_DIR    = qcacld-2.0-$(OSMIO4K_WLAN_QCOM_VER)
OSMIO4K_WLAN_QCOM_SOURCE = qcacld-2.0-$(OSMIO4K_WLAN_QCOM_VER).tar.gz
OSMIO4K_WLAN_QCOM_SITE   = https://www.codeaurora.org/cgit/external/wlan/qcacld-2.0/snapshot

OSMIO4K_WLAN_QCOM_PATCH  = \
	0001-qcacld-2.0-support.patch

$(D)/osmio4k-wlan-qcom: bootstrap kernel osmio4k-wlan-qcom-firmware
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(MAKE) $(KERNEL_MAKEVARS); \
	$(INSTALL_DATA) wlan.ko $(TARGET_MODULES_DIR)/extra
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in wlan; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/wlan.conf; \
	done
	$(PKG_REMOVE)
	$(TOUCH)
