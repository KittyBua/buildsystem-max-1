#
# rtmpdump
#
RTMPDUMP_VER    = git
RTMPDUMP_DIR    = rtmpdump.git
RTMPDUMP_SOURCE = rtmpdump.git
RTMPDUMP_SITE   = git://github.com/oe-alliance

RTMPDUMP_PATCH  = \
	0001-rtmpdump.patch \
	0002-fix-build-openssl102q.patch \
	0003-fix-build-openssl111a.patch

$(D)/rtmpdump: bootstrap zlib openssl
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_CPDIR)
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(MAKE) CROSS_COMPILE=$(TARGET_CROSS) XCFLAGS="-I$(TARGET_INCLUDE_DIR) -L$(TARGET_LIB_DIR)" LDFLAGS="-L$(TARGET_LIB_DIR)"; \
		$(MAKE) install prefix=/usr DESTDIR=$(TARGET_DIR) MANDIR=$(TARGET_DIR)/.remove
	rm -f $(addprefix $(TARGET_DIR)/usr/sbin/,rtmpgw rtmpsrv rtmpsuck)
	$(PKG_REMOVE)
	$(TOUCH)
