################################################################################
#
# Kernel module infrastructure for building Linux kernel modules
#
################################################################################

KERNEL_MAKE_VARS = \
	ARCH=$(KERNEL_ARCH) \
	CROSS_COMPILE=$(TARGET_CROSS) \
	INSTALL_MOD_PATH=$(BUILD_DIR)/$(KERNEL_MODULES) \
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

define KERNEL_MODULE_BUILD
	@$(call MESSAGE,"Building kernel module")
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_MAKE_ENV) $($(PKG)_MAKE_ENV) \
		$($(PKG)_MAKE) \
			$($(PKG)_MAKE_OPTS) $(KERNEL_MAKE_VARS)
endef

# -----------------------------------------------------------------------------

define kernel-module
	$(call PREPARE,$(1))
	$(call KERNEL_MODULE_BUILD)
	$(call LINUX_RUN_DEPMOD)
	$(call TARGET_FOLLOWUP)
endef

# -----------------------------------------------------------------------------

define LINUX_RUN_DEPMOD
	@$(call MESSAGE,"Running depmod")
	if test -d $(TARGET_DIR)/lib/modules/$(KERNEL_VERSION) \
		&& grep -q "CONFIG_MODULES=y" $(KERNEL_OBJ_DIR)/.config; then \
		PATH=$(PATH):/sbin:/usr/sbin depmod -a -b $(TARGET_DIR) $(KERNEL_VERSION); \
	fi
endef
