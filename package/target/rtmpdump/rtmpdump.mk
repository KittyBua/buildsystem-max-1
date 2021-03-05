#
# rtmpdump
#
RTMPDUMP_VER    = git
RTMPDUMP_DIR    = rtmpdump.git
RTMPDUMP_SOURCE = rtmpdump.git
RTMPDUMP_SITE   = git://github.com/oe-alliance
RTMPDUMP_DEPS   = bootstrap zlib openssl

$(D)/rtmpdump:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MAKE) CROSS_COMPILE=$(TARGET_CROSS) XCFLAGS="-I$(TARGET_INCLUDE_DIR) -L$(TARGET_LIB_DIR)" LDFLAGS="-L$(TARGET_LIB_DIR)"; \
		$(MAKE) install prefix=/usr DESTDIR=$(TARGET_DIR) MANDIR=$(TARGET_DIR)$(REMOVE_mandir)
	$(REMOVE)
	rm -f $(addprefix $(TARGET_DIR)/usr/sbin/,rtmpgw rtmpsrv rtmpsuck)
	$(TOUCH)
