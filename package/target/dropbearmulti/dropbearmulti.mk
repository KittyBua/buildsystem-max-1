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
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/dropbear $(TARGET_DIR)/etc/init.d/
endef

define DROPBEARMULTI_INSTALL_FILES
	cd $(TARGET_BIN_DIR) && ln -sf /usr/bin/dropbearmulti dropbear
	mkdir -p $(TARGET_DIR)/etc/dropbear
endef
DROPBEARMULTI_POST_FOLLOWUP_HOOKS += DROPBEARMULTI_INSTALL_FILES

$(D)/dropbearmulti:
	$(call PREPARE)
	$(call TARGET_CONFIGURE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) PROGRAMS="dropbear scp dropbearkey" MULTI=1; \
		$(MAKE) PROGRAMS="dropbear scp dropbearkey" MULTI=1 install DESTDIR=$(TARGET_DIR)
	$(call TARGET_FOLLOWUP)
