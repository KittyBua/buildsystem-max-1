################################################################################
#
# kernel module infrastructure for building Linux kernel modules
#
################################################################################

KERNEL_MAKE_VARS = \
	ARCH=$(KERNEL_ARCH) \
	INSTALL_MOD_PATH=$(BUILD_DIR)/$(KERNEL_MODULES) \
	CROSS_COMPILE=$(TARGET_CROSS) \
	WERROR=0 \
	O=$(KERNEL_OBJ_DIR)

# Compatibility variables
KERNEL_MAKE_VARS += \
	KDIR=$(LINUX_DIR) \
	KSRC=$(LINUX_DIR) \
	SRC=$(LINUX_DIR) \
	KERNDIR=$(LINUX_DIR) \
	KERNELDIR=$(LINUX_DIR) \
	KERNEL_SRC=$(LINUX_DIR) \
	KERNEL_SOURCE=$(LINUX_DIR) \
	LINUX_SRC=$(LINUX_DIR) \
	KVER=$(KERNEL_VERSION) \
	KERNEL_VERSIONSION=$(KERNEL_VERSION)

define kernel-module
	$(call PREPARE)
	@$(call MESSAGE,"Building kernel module(s)")
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) $(KERNEL_MAKE_VARS)
	$(call TARGET_FOLLOWUP)
endef

define LINUX_RUN_DEPMOD
	@$(call MESSAGE,"Run depmod")
	if test -d $(TARGET_DIR)/lib/modules/$(KERNEL_VERSION) \
		&& grep -q "CONFIG_MODULES=y" $(KERNEL_OBJ_DIR)/.config; then \
		PATH=$(PATH):/sbin:/usr/sbin depmod -a -b $(TARGET_DIR) $(KERNEL_VERSION); \
	fi
endef
