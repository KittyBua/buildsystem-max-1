#
# wlan-qcom osmio4k | osmio4kplus
#
WLAN_QCOM_VERSION = 4.5.25.46
WLAN_QCOM_DIR     = qcacld-2.0-$(WLAN_QCOM_VERSION)
WLAN_QCOM_SOURCE  = qcacld-2.0-$(WLAN_QCOM_VERSION).tar.gz
WLAN_QCOM_SITE    = https://www.codeaurora.org/cgit/external/wlan/qcacld-2.0/snapshot
WLAN_QCOM_DEPENDS = bootstrap kernel wlan-qcom-firmware wireless-regdb

$(D)/wlan-qcom:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MAKE) $(KERNEL_MAKEVARS); \
	$(INSTALL_DATA) wlan.ko $(TARGET_MODULES_DIR)/extra
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in wlan; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/wlan.conf; \
	done
	$(LINUX_RUN_DEPMOD)
	$(REMOVE)
	$(TOUCH)
