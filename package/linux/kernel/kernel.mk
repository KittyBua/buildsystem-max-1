#
# makefile to build kernel
#

# arm bre2ze4k/hd51/h7
GFUTURES_PATCH_4_10 = \
	gfutures/4_10_0001-export_pmpoweroffprepare.patch \
	gfutures/4_10_0002-TBS-fixes-for-4.10-kernel.patch \
	gfutures/4_10_0003-Support-TBS-USB-drivers-for-4.6-kernel.patch \
	gfutures/4_10_0004-TBS-fixes-for-4.6-kernel.patch \
	gfutures/4_10_0005-STV-Add-PLS-support.patch \
	gfutures/4_10_0006-STV-Add-SNR-Signal-report-parameters.patch \
	gfutures/4_10_0007-blindscan2.patch \
	gfutures/4_10_0007-stv090x-optimized-TS-sync-control.patch \
	gfutures/4_10_add-more-devices-rtl8xxxu.patch \
	gfutures/4_10_bitsperlong.patch \
	gfutures/4_10_blacklist_mmc0.patch \
	gfutures/4_10_reserve_dvb_adapter_0.patch \
	gfutures/4_10_t230c2.patch

AIRDIGITAL_PATCH_4_10 = \
	$(GFUTURES_PATCH_4_10)

BRE2ZE4K_PATCH = \
	$(GFUTURES_PATCH_4_10)

HD51_PATCH = \
	$(GFUTURES_PATCH_4_10) \
	gfutures/4_10_dvbs2x.patch

H7_PATCH = \
	$(AIRDIGITAL_PATCH_4_10)

# -----------------------------------------------------------------------------

# arm hd60/hd61
GFUTURES_PATCH_4_4 = \
	gfutures/4_4_0001-remote.patch \
	gfutures/4_4_0002-log2-give-up-on-gcc-constant-optimizations.patch \
	gfutures/4_4_0003-dont-mark-register-as-const.patch \
	gfutures/4_4_0004-linux-fix-buffer-size-warning-error.patch \
	gfutures/4_4_0005-xbox-one-tuner-4.4.patch \
	gfutures/4_4_0006-dvb-media-tda18250-support-for-new-silicon-tuner.patch \
	gfutures/4_4_0007-dvb-mn88472-staging.patch \
	gfutures/4_4_HauppaugeWinTV-dualHD.patch \
	gfutures/4_4_dib7000-linux_4.4.179.patch \
	gfutures/4_4_dvb-usb-linux_4.4.179.patch \
	gfutures/4_4_wifi-linux_4.4.183.patch \
	gfutures/4_4_move-default-dialect-to-SMB3.patch \
	gfutures/4_4_modules_mark__inittest__exittest_as__maybe_unused.patch \
	gfutures/4_4_includelinuxmodule_h_copy__init__exit_attrs_to_initcleanup_module.patch \
	gfutures/4_4_Backport_minimal_compiler_attributes_h_to_support_GCC_9.patch \
	gfutures/4_4_mn88472_reset_stream_ID_reg_if_no_PLP_given.patch

HD60_PATCH = \
	$(GFUTURES_PATCH_4_4)

HD61_PATCH = \
	$(GFUTURES_PATCH_4_4)

# -----------------------------------------------------------------------------

# mips vuduo
VUPLUS_PATCH_3_9 = \
	vuplus/3_9_0001-rt2800usb-add-support-for-rt55xx.patch \
	vuplus/3_9_0001-stv090x-optimized-TS-sync-control.patch \
	vuplus/3_9_0001-STV-Add-PLS-support.patch \
	vuplus/3_9_0001-STV-Add-SNR-Signal-report-parameters.patch \
	vuplus/3_9_0001-Support-TBS-USB-drivers-3.9.patch \
	vuplus/3_9_01-10-si2157-Silicon-Labs-Si2157-silicon-tuner-driver.patch \
	vuplus/3_9_02-10-si2168-Silicon-Labs-Si2168-DVB-T-T2-C-demod-driver.patch \
	vuplus/3_9_add-dmx-source-timecode.patch \
	vuplus/3_9_af9015-output-full-range-SNR.patch \
	vuplus/3_9_af9033-output-full-range-SNR.patch \
	vuplus/3_9_as102-adjust-signal-strength-report.patch \
	vuplus/3_9_as102-scale-MER-to-full-range.patch \
	vuplus/3_9_blindscan2.patch \
	vuplus/3_9_cinergy_s2_usb_r2.patch \
	vuplus/3_9_CONFIG_DVB_SP2.patch \
	vuplus/3_9_cxd2820r-output-full-range-SNR.patch \
	vuplus/3_9_dvbsky-t330.patch \
	vuplus/3_9_dvb-usb-dib0700-disable-sleep.patch \
	vuplus/3_9_dvb_usb_disable_rc_polling.patch \
	vuplus/3_9_fix-dvb-siano-sms-order.patch \
	vuplus/3_9_fix_fuse_for_linux_mips_3-9.patch \
	vuplus/3_9_genksyms_fix_typeof_handling.patch \
	vuplus/3_9_0002-log2-give-up-on-gcc-constant-optimizations.patch \
	vuplus/3_9_0003-cp1emu-do-not-use-bools-for-arithmetic.patch \
	vuplus/3_9_it913x-switch-off-PID-filter-by-default.patch \
	vuplus/3_9_kernel-add-support-for-gcc5.patch \
	vuplus/3_9_kernel-add-support-for-gcc6.patch \
	vuplus/3_9_kernel-add-support-for-gcc7.patch \
	vuplus/3_9_kernel-add-support-for-gcc8.patch \
	vuplus/3_9_kernel-add-support-for-gcc9.patch \
	vuplus/3_9_gcc9_backport.patch \
	vuplus/3_9_linux-3.9-gcc-4.9.3-build-error-fixed.patch \
	vuplus/3_9_linux-sata_bcm.patch \
	vuplus/3_9_mxl5007t-add-no_probe-and-no_reset-parameters.patch \
	vuplus/3_9_nfs-max-rwsize-8k.patch \
	vuplus/3_9_rt2800usb_fix_warn_tx_status_timeout_to_dbg.patch \
	vuplus/3_9_rtl8187se-fix-warnings.patch \
	vuplus/3_9_rtl8712-fix-warnings.patch \
	vuplus/3_9_tda18271-advertise-supported-delsys.patch \
	vuplus/3_9_test.patch

VUDUO_PATCH = \
	$(VUPLUS_PATCH_3_9)

# -----------------------------------------------------------------------------

# arm vusolo4k/vuultimo4k/vuuno4k
VUPLUS_PATCH_3_14 = \
	vuplus/3_14_bcm_genet_disable_warn.patch \
	vuplus/3_14_linux_dvb-core.patch \
	vuplus/3_14_dvbs2x.patch \
	vuplus/3_14_dmx_source_dvr.patch \
	vuplus/3_14_rt2800usb_fix_warn_tx_status_timeout_to_dbg.patch \
	vuplus/3_14_usb_core_hub_msleep.patch \
	vuplus/3_14_rtl8712_fix_build_error.patch \
	vuplus/3_14_kernel-add-support-for-gcc6.patch \
	vuplus/3_14_kernel-add-support-for-gcc7.patch \
	vuplus/3_14_kernel-add-support-for-gcc8.patch \
	vuplus/3_14_kernel-add-support-for-gcc9.patch \
	vuplus/3_14_0001-Support-TBS-USB-drivers.patch \
	vuplus/3_14_0001-STV-Add-PLS-support.patch \
	vuplus/3_14_0001-STV-Add-SNR-Signal-report-parameters.patch \
	vuplus/3_14_0001-stv090x-optimized-TS-sync-control.patch \
	vuplus/3_14_blindscan2.patch \
	vuplus/3_14_genksyms_fix_typeof_handling.patch \
	vuplus/3_14_0001-tuners-tda18273-silicon-tuner-driver.patch \
	vuplus/3_14_01-10-si2157-Silicon-Labs-Si2157-silicon-tuner-driver.patch \
	vuplus/3_14_02-10-si2168-Silicon-Labs-Si2168-DVB-T-T2-C-demod-driver.patch \
	vuplus/3_14_0003-cxusb-Geniatech-T230-support.patch \
	vuplus/3_14_CONFIG_DVB_SP2.patch \
	vuplus/3_14_dvbsky.patch \
	vuplus/3_14_rtl2832u-2.patch \
	vuplus/3_14_0004-log2-give-up-on-gcc-constant-optimizations.patch \
	vuplus/3_14_0005-uaccess-dont-mark-register-as-const.patch \
	vuplus/3_14_0006-makefile-disable-warnings.patch \
	vuplus/3_14_linux_dvb_adapter.patch

VUSOLO4K_PATCH = \
	$(VUPLUS_PATCH_3_14) \
	vuplus/3_14_linux_rpmb_not_alloc.patch \
	vuplus/3_14_fix_mmc_3.14.28-1.10.patch

VUULTIMO4K_PATCH = \
	$(VUPLUS_PATCH_3_14) \
	vuplus/3_14_bcmsysport_3.14.28-1.12.patch \
	vuplus/3_14_linux_prevent_usb_dma_from_bmem.patch

VUUNO4K_PATCH = \
	$(VUPLUS_PATCH_3_14) \
	vuplus/3_14_bcmsysport_3.14.28-1.12.patch \
	vuplus/3_14_linux_prevent_usb_dma_from_bmem.patch

# -----------------------------------------------------------------------------

# arm vuduo4k/vuduo4kse/vuuno4kse/vuzero4k
VUPLUS_PATCH_4_1 = \
	vuplus/4_1_linux_dvb_adapter.patch \
	vuplus/4_1_linux_dvb-core.patch \
	vuplus/4_1_linux_4_1_45_dvbs2x.patch \
	vuplus/4_1_dmx_source_dvr.patch \
	vuplus/4_1_bcmsysport_4_1_45.patch \
	vuplus/4_1_linux_usb_hub.patch \
	vuplus/4_1_0001-regmap-add-regmap_write_bits.patch \
	vuplus/4_1_0002-af9035-fix-device-order-in-ID-list.patch \
	vuplus/4_1_0003-Add-support-for-dvb-usb-stick-Hauppauge-WinTV-soloHD.patch \
	vuplus/4_1_0004-af9035-add-USB-ID-07ca-0337-AVerMedia-HD-Volar-A867.patch \
	vuplus/4_1_0005-Add-support-for-EVOLVEO-XtraTV-stick.patch \
	vuplus/4_1_0006-dib8000-Add-support-for-Mygica-Geniatech-S2870.patch \
	vuplus/4_1_0007-dib0700-add-USB-ID-for-another-STK8096-PVR-ref-desig.patch \
	vuplus/4_1_0008-add-Hama-Hybrid-DVB-T-Stick-support.patch \
	vuplus/4_1_0009-Add-Terratec-H7-Revision-4-to-DVBSky-driver.patch \
	vuplus/4_1_0010-media-Added-support-for-the-TerraTec-T1-DVB-T-USB-tu.patch \
	vuplus/4_1_0011-media-tda18250-support-for-new-silicon-tuner.patch \
	vuplus/4_1_0012-media-dib0700-add-support-for-Xbox-One-Digital-TV-Tu.patch \
	vuplus/4_1_0013-mn88472-Fix-possible-leak-in-mn88472_init.patch \
	vuplus/4_1_0014-staging-media-Remove-unneeded-parentheses.patch \
	vuplus/4_1_0015-staging-media-mn88472-simplify-NULL-tests.patch \
	vuplus/4_1_0016-mn88472-fix-typo.patch \
	vuplus/4_1_0017-mn88472-finalize-driver.patch \
	vuplus/4_1_0001-dvb-usb-fix-a867.patch \
	vuplus/4_1_kernel-add-support-for-gcc6.patch \
	vuplus/4_1_kernel-add-support-for-gcc7.patch \
	vuplus/4_1_kernel-add-support-for-gcc8.patch \
	vuplus/4_1_kernel-add-support-for-gcc9.patch \
	vuplus/4_1_kernel-add-support-for-gcc10.patch \
	vuplus/4_1_0001-Support-TBS-USB-drivers-for-4.1-kernel.patch \
	vuplus/4_1_0001-TBS-fixes-for-4.1-kernel.patch \
	vuplus/4_1_0001-STV-Add-PLS-support.patch \
	vuplus/4_1_0001-STV-Add-SNR-Signal-report-parameters.patch \
	vuplus/4_1_blindscan2.patch \
	vuplus/4_1_0001-stv090x-optimized-TS-sync-control.patch \
	vuplus/4_1_0002-log2-give-up-on-gcc-constant-optimizations.patch \
	vuplus/4_1_0003-uaccess-dont-mark-register-as-const.patch

VUDUO4K_PATCH = \
	$(VUPLUS_PATCH_4_1)

VUDUO4KSE_PATCH = \
	$(VUPLUS_PATCH_4_1)

VUUNO4KSE_PATCH = \
	$(VUPLUS_PATCH_4_1) \
	vuplus/4_1_bcmgenet-recovery-fix.patch \
	vuplus/4_1_linux_rpmb_not_alloc.patch

VUZERO4K_PATCH = \
	$(VUPLUS_PATCH_4_1) \
	vuplus/4_1_bcmgenet-recovery-fix.patch \
	vuplus/4_1_linux_rpmb_not_alloc.patch

# -----------------------------------------------------------------------------

EDISION_PATCH_5_9 = \
	edision/0001-scripts-Use-fixed-input-and-output-files-instead-of-.patch \
	edision/0002-kbuild-install_headers.sh-Strip-_UAPI-from-if-define.patch

OSMIO4K_PATCH = \
	$(EDISION_PATCH_5_9)

OSMIO4KPLUS_PATCH = \
	$(EDISION_PATCH_5_9)

# -----------------------------------------------------------------------------

$(D)/kernel.do_prepare:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$($(call UPPERCASE,$(BOXMODEL))_PATCH))
	@touch $@

$(D)/kernel.do_compile: kernel.do_prepare
	$(REMOVE)/$(KERNEL_OBJ)
	$(REMOVE)/$(KERNEL_MODULES)
	$(MKDIR)/$(KERNEL_OBJ)
	$(MKDIR)/$(KERNEL_MODULES)
	$(INSTALL_DATA) $(PKG_FILES_DIR)/$(KERNEL_CONFIG) $(KERNEL_OBJ_DIR)/.config
ifeq ($(BOXMODEL),$(filter $(BOXMODEL),bre2ze4k hd51 hd60 hd61 h7))
	$(INSTALL_DATA) $(PKG_FILES_DIR)/initramfs-subdirboot.cpio.gz $(KERNEL_OBJ_DIR)
endif
	$(PKG_CHDIR); \
		$(MAKE) $(KERNEL_MAKEVARS) oldconfig; \
		$(MAKE) $(KERNEL_MAKEVARS) modules $(KERNEL_DTB) $(KERNEL_IMAGE_TYPE); \
		$(MAKE) $(KERNEL_MAKEVARS) modules_install
ifeq ($(BOXMODEL),$(filter $(BOXMODEL),bre2ze4k hd51 h7))
	cat $(KERNEL_OUTPUT) $(KERNEL_INPUT_DTB) > $(KERNEL_OUTPUT_DTB)
endif
	@touch $@

$(D)/kernel: bootstrap kernel.do_compile
	mkdir -p $(TARGET_MODULES_DIR)
	cp -a $(KERNEL_MODULES_DIR)/kernel $(TARGET_MODULES_DIR)
	cp -a $(KERNEL_MODULES_DIR)/modules.builtin $(TARGET_MODULES_DIR)
	cp -a $(KERNEL_MODULES_DIR)/modules.order $(TARGET_MODULES_DIR)
	cp -aR $(PKG_FILES_DIR)/firmware/* $(TARGET_DIR)/
	$(TOUCH)

# -----------------------------------------------------------------------------

kernel-config: bootstrap kernel.do_compile
	$(PKG_CHDIR); \
		make $(KERNEL_MAKEVARS) menuconfig
	@echo ""
	@echo -e "You have to edit $(KERNEL_CONFIG) $(TERM_YELLOW)m a n u a l l y$(TERM_NORMAL) to make changes permanent !!!"
	@echo ""
	diff $(KERNEL_OBJ_DIR)/.config.old $(KERNEL_OBJ_DIR)/.config
	@echo ""

# -----------------------------------------------------------------------------

kernel-modules-clean:
	rm -fr $(TARGET_MODULES_DIR)/kernel/arch
	rm -fr $(TARGET_MODULES_DIR)/kernel/crypto
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/bluetooth
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/i2c
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/input
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/media
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/mfd
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/net/ppp
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/net/slip
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/ath/ar5523
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/ath/ath10k
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/ath/ath6kl
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/ath/ath9k/ath9k.ko
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/atmel
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/broadcom
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/intersil
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/marvell
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/mediatek
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/realtek/rtl8xxxu
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/rsi
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/st
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/ti
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/zydas/zd1201.ko
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/staging/rtl8192e
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/staging/rtl8192u
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/staging/wlan-ng
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/usb/class
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/usb/serial/ark3116.ko
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/usb/serial/ch341.ko
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/usb/serial/cp210x.ko
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/usb/serial/f81232.ko
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/usb/serial/option.ko
	rm -fr $(TARGET_MODULES_DIR)/kernel/drivers/usb/serial/usb_wwan.ko
	rm -fr $(TARGET_MODULES_DIR)/kernel/lib/crc7.ko
	rm -fr $(TARGET_MODULES_DIR)/kernel/fs/ext2
	rm -fr $(TARGET_MODULES_DIR)/kernel/fs/f2fs
	rm -fr $(TARGET_MODULES_DIR)/kernel/fs/jffs2
	rm -fr $(TARGET_MODULES_DIR)/kernel/fs/nfs
	rm -fr $(TARGET_MODULES_DIR)/kernel/fs/nls
	rm -fr $(TARGET_MODULES_DIR)/kernel/fs/ntfs
	rm -fr $(TARGET_MODULES_DIR)/kernel/fs/squashfs
	rm -fr $(TARGET_MODULES_DIR)/kernel/net/802
	rm -fr $(TARGET_MODULES_DIR)/kernel/net/appletalk
	rm -fr $(TARGET_MODULES_DIR)/kernel/net/bluetooth
	rm -fr $(TARGET_MODULES_DIR)/kernel/net/bridge
	rm -fr $(TARGET_MODULES_DIR)/kernel/net/core
	rm -fr $(TARGET_MODULES_DIR)/kernel/net/ipv6/ah6.ko
	rm -fr $(TARGET_MODULES_DIR)/kernel/net/ipv6/esp6.ko
	rm -fr $(TARGET_MODULES_DIR)/kernel/net/ipv6/ipcomp6.ko
	rm -fr $(TARGET_MODULES_DIR)/kernel/net/ipv6/mip6.ko
	rm -fr $(TARGET_MODULES_DIR)/kernel/net/ipv6/sit.ko
	rm -fr $(TARGET_MODULES_DIR)/kernel/net/llc
	rm -fr $(TARGET_MODULES_DIR)/kernel/net/sunrpc
	@touch $(D)/$(notdir $@)
