################################################################################
#
# hd61-mali-module
#
################################################################################

HD61_MALI_MODULE_VERSION = DX910-SW-99002-r7p0-00rel0
HD61_MALI_MODULE_DIR = $(HD61_MALI_MODULE_VERSION)
HD61_MALI_MODULE_SOURCE = $(HD61_MALI_MODULE_VERSION).tgz
HD61_MALI_MODULE_SITE = https://developer.arm.com/-/media/Files/downloads/mali-drivers/kernel/mali-utgard-gpu
HD61_MALI_MODULE_DEPENDS = kernel hd61-libgles-header

HD61_MALI_MODULE_MAKEVARS = \
	M=$(PKG_BUILD_DIR)/driver/src/devicedrv/mali \
	EXTRA_CFLAGS=" \
	-DCONFIG_MALI_DVFS=y \
	-DCONFIG_GPU_AVS_ENABLE=y" \
	CONFIG_MALI_SHARED_INTERRUPTS=y \
	CONFIG_MALI400=m \
	CONFIG_MALI450=y \
	CONFIG_MALI_DVFS=y \
	CONFIG_GPU_AVS_ENABLE=y

$(D)/hd61-mali-module: | bootstrap
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) -C $(LINUX_DIR) $(KERNEL_MAKE_VARS) \
		$(HD61_MALI_MODULE_MAKEVARS); \
		$(MAKE) -C $(LINUX_DIR) $(KERNEL_MAKE_VARS) \
		$(HD61_MALI_MODULE_MAKEVARS) \
		INSTALL_MOD_PATH=$(TARGET_DIR) \
		modules_install
#	mkdir -p ${TARGET_DIR}/etc/modules-load.d
#	echo mali > ${TARGET_DIR}/etc/modules-load.d/mali.conf
	$(call TARGET_FOLLOWUP)
