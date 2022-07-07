################################################################################
#
# libevent
#
################################################################################

LIBEVENT_VERSION = 2.1.11-stable
LIBEVENT_DIR = libevent-$(LIBEVENT_VERSION)
LIBEVENT_SOURCE = libevent-$(LIBEVENT_VERSION).tar.gz
LIBEVENT_SITE = https://github.com/libevent/libevent/releases/download/release-$(LIBEVENT_VERSION)

LIBEVENT_DEPENDS = bootstrap

define LIBEVENT_TARGET_CLEANUP
	rm -f $(addprefix $(TARGET_BIN_DIR)/,event_rpcgen.py)
endef
LIBEVENT_TARGET_CLEANUP_HOOKS += LIBEVENT_TARGET_CLEANUP

$(D)/libevent:
	$(call autotools-package)
