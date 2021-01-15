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
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(MAKE) CROSS_COMPILE=$(TARGET_CROSS) XCFLAGS="-I$(TARGET_INCLUDE_DIR) -L$(TARGET_LIB_DIR)" LDFLAGS="-L$(TARGET_LIB_DIR)"; \
		$(MAKE) install prefix=/usr DESTDIR=$(TARGET_DIR) MANDIR=$(TARGET_DIR)$(REMOVE_mandir)
	rm -f $(addprefix $(TARGET_DIR)/usr/sbin/,rtmpgw rtmpsrv rtmpsuck)
	$(PKG_REMOVE)
	$(TOUCH)
