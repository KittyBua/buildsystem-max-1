################################################################################
#
# makefile to build kernel
#
################################################################################

LINUX_KERNEL_MAKE_VARS = \
	$(KERNEL_MAKE_VARS) \
	INSTALL_MOD_PATH=$(BUILD_DIR)/$(KERNEL_MODULES)

$(D)/kernel.do_prepare:
	$(call PREPARE)
	@touch $@

$(D)/kernel.do_compile: kernel.do_prepare
	rm -rf $(BUILD_DIR)/$(KERNEL_OBJ)
	rm -rf $(BUILD_DIR)/$(KERNEL_MODULES)
	$(MKDIR)/$(KERNEL_OBJ)
	$(MKDIR)/$(KERNEL_MODULES)
	$(INSTALL_DATA) $(PKG_FILES_DIR)/$(KERNEL_CONFIG) $(KERNEL_OBJ_DIR)/.config
ifeq ($(BOXMODEL),$(filter $(BOXMODEL),bre2ze4k hd51 hd60 hd61 h7))
	$(INSTALL_DATA) $(PKG_FILES_DIR)/initramfs-subdirboot.cpio.gz $(KERNEL_OBJ_DIR)
endif
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) $(LINUX_KERNEL_MAKE_VARS) oldconfig; \
		$(MAKE) $(LINUX_KERNEL_MAKE_VARS) modules $(KERNEL_DTB) $(KERNEL_IMAGE_TYPE); \
		$(MAKE) $(LINUX_KERNEL_MAKE_VARS) modules_install
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

kernel-clean:
	@printf "$(TERM_YELLOW)===> clean $(subst -clean,,$@) .. $(TERM_NORMAL)"
	@rm -f $(D)/kernel
	@rm -f $(D)/kernel.do_compile
	@printf "$(TERM_YELLOW)done\n$(TERM_NORMAL)"

kernel-distclean:
	@printf "$(TERM_YELLOW)===> distclean $(subst -distclean,,$@) .. $(TERM_NORMAL)"
	@rm -f $(D)/kernel
	@rm -f $(D)/kernel.do_compile
	@rm -f $(D)/kernel.do_prepare
	@printf "$(TERM_YELLOW)done\n$(TERM_NORMAL)"

# -----------------------------------------------------------------------------

kernel-config: bootstrap kernel.do_compile
	$(CHDIR)/$($(PKG)_DIR); \
		make $(KERNEL_MAKE_VARS) menuconfig
	@echo ""
	@echo -e "You have to edit $(KERNEL_CONFIG) $(TERM_YELLOW)m a n u a l l y$(TERM_NORMAL) to make changes permanent !!!"
	@echo ""
	diff $(KERNEL_OBJ_DIR)/.config.old $(KERNEL_OBJ_DIR)/.config
	@echo ""

# -----------------------------------------------------------------------------

kernel-modules-clean:
	rm -rf $(TARGET_MODULES_DIR)/kernel/arch
	rm -rf $(TARGET_MODULES_DIR)/kernel/crypto
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/bluetooth
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/i2c
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/input
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/media
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/mfd
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/net/ppp
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/net/slip
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/ath/ar5523
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/ath/ath10k
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/ath/ath6kl
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/ath/ath9k/ath9k.ko
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/atmel
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/broadcom
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/intersil
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/marvell
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/mediatek
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/realtek/rtl8xxxu
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/rsi
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/st
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/ti
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/zydas/zd1201.ko
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/staging/rtl8192e
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/staging/rtl8192u
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/staging/wlan-ng
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/usb/class
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/usb/serial/ark3116.ko
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/usb/serial/ch341.ko
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/usb/serial/cp210x.ko
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/usb/serial/f81232.ko
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/usb/serial/option.ko
	rm -rf $(TARGET_MODULES_DIR)/kernel/drivers/usb/serial/usb_wwan.ko
	rm -rf $(TARGET_MODULES_DIR)/kernel/lib/crc7.ko
	rm -rf $(TARGET_MODULES_DIR)/kernel/fs/ext2
	rm -rf $(TARGET_MODULES_DIR)/kernel/fs/f2fs
	rm -rf $(TARGET_MODULES_DIR)/kernel/fs/jffs2
	rm -rf $(TARGET_MODULES_DIR)/kernel/fs/nfs
	rm -rf $(TARGET_MODULES_DIR)/kernel/fs/nls
	rm -rf $(TARGET_MODULES_DIR)/kernel/fs/ntfs
	rm -rf $(TARGET_MODULES_DIR)/kernel/fs/squashfs
	rm -rf $(TARGET_MODULES_DIR)/kernel/net/802
	rm -rf $(TARGET_MODULES_DIR)/kernel/net/appletalk
	rm -rf $(TARGET_MODULES_DIR)/kernel/net/bluetooth
	rm -rf $(TARGET_MODULES_DIR)/kernel/net/bridge
	rm -rf $(TARGET_MODULES_DIR)/kernel/net/core
	rm -rf $(TARGET_MODULES_DIR)/kernel/net/ipv6/ah6.ko
	rm -rf $(TARGET_MODULES_DIR)/kernel/net/ipv6/esp6.ko
	rm -rf $(TARGET_MODULES_DIR)/kernel/net/ipv6/ipcomp6.ko
	rm -rf $(TARGET_MODULES_DIR)/kernel/net/ipv6/mip6.ko
	rm -rf $(TARGET_MODULES_DIR)/kernel/net/ipv6/sit.ko
	rm -rf $(TARGET_MODULES_DIR)/kernel/net/llc
	rm -rf $(TARGET_MODULES_DIR)/kernel/net/sunrpc
	@touch $(D)/$(notdir $@)
