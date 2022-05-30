################################################################################
#
# libevent
#
################################################################################

LIBEVENT_VERSION = 2.1.11-stable
LIBEVENT_DIR     = libevent-$(LIBEVENT_VERSION)
LIBEVENT_SOURCE  = libevent-$(LIBEVENT_VERSION).tar.gz
LIBEVENT_SITE    = https://github.com/libevent/libevent/releases/download/release-$(LIBEVENT_VERSION)
LIBEVENT_DEPENDS = bootstrap

define LIBEVENT_CLEANUP_TARGET
	rm -f $(addprefix $(TARGET_BIN_DIR)/,event_rpcgen.py)
endef
LIBEVENT_CLEANUP_TARGET_HOOKS += LIBEVENT_CLEANUP_TARGET

$(D)/libevent:
	$(call make-package)
