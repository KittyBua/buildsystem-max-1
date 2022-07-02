################################################################################
#
# astra-sm
#
################################################################################

ASTRA_SM_VERSION = git
ASTRA_SM_DIR     = astra-sm.git
ASTRA_SM_SOURCE  = astra-sm.git
ASTRA_SM_SITE    = https://gitlab.com/crazycat69
ASTRA_SM_DEPENDS = bootstrap openssl

ASTRA_SM_AUTORECONF = YES

ifeq ($(GCC_VERSION),$(filter $(GCC_VERSION),11.3.0 12.1.0))
ASTRA_SM_PATCH += 0004-replace-sys-siglist.patch-gcc
endif

ASTRA_SM_CONF_OPTS = \
	--without-lua

define ASTRA_SM_TARGET_CLEANUP
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,astra)
endef
ASTRA_SM_TARGET_CLEANUP_HOOKS += ASTRA_SM_TARGET_CLEANUP

$(D)/astra-sm:
	$(call autotools-package)
