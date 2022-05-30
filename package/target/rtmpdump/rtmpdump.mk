################################################################################
#
# rtmpdump
#
################################################################################

RTMPDUMP_VERSION = git
RTMPDUMP_DIR     = rtmpdump.git
RTMPDUMP_SOURCE  = rtmpdump.git
RTMPDUMP_SITE    = https://github.com/oe-alliance
RTMPDUMP_DEPENDS = bootstrap zlib openssl

define RTMPDUMP_CLEANUP_TARGET
	rm -f $(addprefix $(TARGET_SBIN_DIR)/,rtmpgw rtmpsrv rtmpsuck)
endef
RTMPDUMP_CLEANUP_TARGET_HOOKS += RTMPDUMP_CLEANUP_TARGET

$(D)/rtmpdump:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) CROSS_COMPILE=$(TARGET_CROSS) XCFLAGS="-I$(TARGET_INCLUDE_DIR) -L$(TARGET_LIB_DIR)" LDFLAGS="-L$(TARGET_LIB_DIR)"; \
		$(MAKE) install prefix=/usr DESTDIR=$(TARGET_DIR) MANDIR=$(TARGET_DIR)$(REMOVE_mandir)
	$(call TARGET_FOLLOWUP)
