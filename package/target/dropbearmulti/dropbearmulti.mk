#
# dropbearmulti
#
DROPBEARMULTI_VER      = git
DROPBEARMULTI_DIR      = dropbear.git
DROPBEARMULTI_SOURCE   = dropbear.git
DROPBEARMULTI_SITE     = https://github.com/mkj
DROPBEARMULTI_CHECKOUT = c8d852c

DROPBEARMULTI_CONF_OPTS = \
	--localedir=$(REMOVE_localedir) \
	--disable-syslog \
	--disable-lastlog \
	--disable-shadow \
	--disable-zlib \
	--disable-utmp \
	--disable-utmpx \
	--disable-wtmp \
	--disable-wtmpx \
	--disable-loginfunc \
	--disable-pututline \
	--disable-pututxline

$(D)/dropbearmulti: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(BUILD_ENV) \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE); \
		$(MAKE) PROGRAMS="dropbear scp dropbearkey" MULTI=1; \
		$(MAKE) PROGRAMS="dropbear scp dropbearkey" MULTI=1 install DESTDIR=$(TARGET_DIR)
	cd $(TARGET_DIR)/usr/bin && ln -sf /usr/bin/dropbearmulti dropbear
	mkdir -p $(TARGET_DIR)/etc/dropbear
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/dropbear $(TARGET_DIR)/etc/init.d/
	$(PKG_REMOVE)
	$(TOUCH)
