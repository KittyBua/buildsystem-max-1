################################################################################
#
# iproute2
#
################################################################################

IPROUTE2_VERSION = 5.7.0
IPROUTE2_DIR = iproute2-$(IPROUTE2_VERSION)
IPROUTE2_SOURCE = iproute2-$(IPROUTE2_VERSION).tar.xz
IPROUTE2_SITE = https://kernel.org/pub/linux/utils/net/iproute2

IPROUTE2_DEPENDS = bootstrap libmnl

define IPROUTE2_TARGET_CLEANUP
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,man)
endef
IPROUTE2_TARGET_CLEANUP_HOOKS += IPROUTE2_TARGET_CLEANUP

$(D)/iproute2:
	$(call autotools-package)
