################################################################################
#
# rtmpdump
#
################################################################################

RTMPDUMP_VERSION = git
RTMPDUMP_DIR = rtmpdump.git
RTMPDUMP_SOURCE = rtmpdump.git
RTMPDUMP_SITE = https://github.com/oe-alliance

RTMPDUMP_DEPENDS = bootstrap zlib openssl

RTMPDUMP_MAKE_ENV = \
	CROSS_COMPILE=$(TARGET_CROSS) \
	XCFLAGS="-I$(TARGET_INCLUDE_DIR) -L$(TARGET_LIB_DIR)" \
	LDFLAGS="-L$(TARGET_LIB_DIR)"

RTMPDUMP_MAKE_OPTS = \
	prefix=/usr \
	MANDIR=$(TARGET_DIR)$(REMOVE_mandir)

define RTMPDUMP_TARGET_CLEANUP
	rm -f $(addprefix $(TARGET_SBIN_DIR)/,rtmpgw rtmpsrv rtmpsuck)
endef
RTMPDUMP_TARGET_CLEANUP_HOOKS += RTMPDUMP_TARGET_CLEANUP

$(D)/rtmpdump:
	$(call make-package)
