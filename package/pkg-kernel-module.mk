################################################################################
#
# kernel module infrastructure for building Linux kernel modules
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

define KERNEL_MODULE_BUILD_CMDS_DEFAULT
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_MAKE_ENV) $($(PKG)_MAKE_ENV) \
		$($(PKG)_MAKE) \
			$($(PKG)_MAKE_OPTS) $(KERNEL_MAKE_VARS)
endef

define KERNEL_MODULE_BUILD
	@$(call MESSAGE,"Building kernel module")
	$(foreach hook,$($(PKG)_PRE_BUILD_HOOKS),$(call $(hook))$(sep))
	$(Q)$(call $(PKG)_BUILD_CMDS)
	$(foreach hook,$($(PKG)_POST_BUILD_HOOKS),$(call $(hook))$(sep))
endef

# -----------------------------------------------------------------------------

define kernel-module
	$(eval PKG_MODE = $(pkg-mode))
	$(call PREPARE,$(1))
	$(call KERNEL_MODULE_BUILD)
	$(call LINUX_RUN_DEPMOD)
	$(call TARGET_FOLLOWUP)
endef

# -----------------------------------------------------------------------------

define LINUX_RUN_DEPMOD
	@$(call MESSAGE,"Running depmod")
	if test -d $(TARGET_MODULES_DIR) && grep -q "CONFIG_MODULES=y" $(KERNEL_OBJ_DIR)/.config; then \
		PATH=$(PATH):/sbin:/usr/sbin depmod -a -b $(TARGET_DIR) $(KERNEL_VERSION); \
	fi
endef
