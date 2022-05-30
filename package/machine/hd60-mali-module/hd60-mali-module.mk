################################################################################
#
# hd60-mali-module
#
################################################################################

HD60_MALI_MODULE_VERSION = DX910-SW-99002-r7p0-00rel0
HD60_MALI_MODULE_DIR     = $(HD60_MALI_MODULE_VERSION)
HD60_MALI_MODULE_SOURCE  = $(HD60_MALI_MODULE_VERSION).tgz
HD60_MALI_MODULE_SITE    = https://developer.arm.com/-/media/Files/downloads/mali-drivers/kernel/mali-utgard-gpu
HD60_MALI_MODULE_DEPENDS = bootstrap kernel hd60-libgles-header

HD60_MALI_MODULE_MAKEVARS = \
	M=$(PKG_BUILD_DIR)/driver/src/devicedrv/mali \
	EXTRA_CFLAGS=" \
	-DCONFIG_MALI_DVFS=y \
	-DCONFIG_GPU_AVS_ENABLE=y" \
	CONFIG_MALI_SHARED_INTERRUPTS=y \
	CONFIG_MALI400=m \
	CONFIG_MALI450=y \
	CONFIG_MALI_DVFS=y \
	CONFIG_GPU_AVS_ENABLE=y

$(D)/hd60-mali-module:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) -C $(LINUX_DIR) $(KERNEL_MAKEVARS) \
		$(HD60_MALI_MODULE_MAKEVARS); \
		$(MAKE) -C $(LINUX_DIR) $(KERNEL_MAKEVARS) \
		$(HD60_MALI_MODULE_MAKEVARS) \
		INSTALL_MOD_PATH=$(TARGET_DIR) \
		modules_install
#	mkdir -p ${TARGET_DIR}/etc/modules-load.d
#	echo mali > ${TARGET_DIR}/etc/modules-load.d/mali.conf
	$(call TARGET_FOLLOWUP)
