################################################################################
#
# iproute2
#
################################################################################

IPROUTE2_VERSION = 5.7.0
IPROUTE2_DIR     = iproute2-$(IPROUTE2_VERSION)
IPROUTE2_SOURCE  = iproute2-$(IPROUTE2_VERSION).tar.xz
IPROUTE2_SITE    = https://kernel.org/pub/linux/utils/net/iproute2
IPROUTE2_DEPENDS = bootstrap libmnl

define IPROUTE2_CLEANUP_TARGET
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,man)
endef
IPROUTE2_CLEANUP_TARGET_HOOKS += IPROUTE2_CLEANUP_TARGET

$(D)/iproute2:
	$(call make-package)
