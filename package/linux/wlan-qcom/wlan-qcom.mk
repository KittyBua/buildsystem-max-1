#
# wlan-qcom osmio4k | osmio4kplus
#
WLAN_QCOM_VER    = 4.5.25.46
WLAN_QCOM_DIR    = qcacld-2.0-$(WLAN_QCOM_VER)
WLAN_QCOM_SOURCE = qcacld-2.0-$(WLAN_QCOM_VER).tar.gz
WLAN_QCOM_SITE   = https://www.codeaurora.org/cgit/external/wlan/qcacld-2.0/snapshot
WLAN_QCOM_DEPS   = bootstrap kernel wlan-qcom-firmware wireless-regdb

$(D)/wlan-qcom:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(MAKE) $(KERNEL_MAKEVARS); \
	$(INSTALL_DATA) wlan.ko $(TARGET_MODULES_DIR)/extra
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in wlan; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/wlan.conf; \
	done
	$(LINUX_RUN_DEPMOD)
	$(PKG_REMOVE)
	$(TOUCH)
