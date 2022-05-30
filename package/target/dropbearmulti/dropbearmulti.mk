################################################################################
#
# dropbearmulti
#
################################################################################

DROPBEARMULTI_VERSION = git
DROPBEARMULTI_DIR     = dropbear.git
DROPBEARMULTI_SOURCE  = dropbear.git
DROPBEARMULTI_SITE    = https://github.com/mkj
DROPBEARMULTI_DEPENDS = bootstrap

DROPBEARMULTI_CHECKOUT = 846d38f

DROPBEARMULTI_AUTORECONF = YES

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

define DROPBEARMULTI_INSTALL_INIT_SYSV
	cd $(TARGET_BIN_DIR) && ln -sf /usr/bin/dropbearmulti dropbear
	mkdir -p $(TARGET_DIR)/etc/dropbear
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/dropbear $(TARGET_DIR)/etc/init.d/
endef

$(D)/dropbearmulti:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE); \
		$(MAKE) PROGRAMS="dropbear scp dropbearkey" MULTI=1; \
		$(MAKE) PROGRAMS="dropbear scp dropbearkey" MULTI=1 install DESTDIR=$(TARGET_DIR)
	$(call TARGET_FOLLOWUP)
