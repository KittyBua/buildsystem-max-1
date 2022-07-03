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

DROPBEAR_MAKE_OPTS = \
	SCPPROGRESS=1 \
	PROGRAMS="dropbear dbclient dropbearkey scp"

define DROPBEARMULTI_INSTALL_INIT_SYSV
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/dropbear $(TARGET_DIR)/etc/init.d/
endef

define DROPBEAR_CONFIGURE_LOCALOPTIONS
	# Ensure that dropbear doesn't use crypt() when it's not available
	echo '#if !HAVE_CRYPT'				>> $(PKG_BUILD_DIR)/localoptions.h
	echo '#define DROPBEAR_SVR_PASSWORD_AUTH 0'	>> $(PKG_BUILD_DIR)/localoptions.h
	echo '#endif'					>> $(PKG_BUILD_DIR)/localoptions.h
	# disable SMALL_CODE define
	echo '#define DROPBEAR_SMALL_CODE 0'		>> $(PKG_BUILD_DIR)/localoptions.h
	# fix PATH define
	echo '#define DEFAULT_PATH "/sbin:/bin:/usr/sbin:/usr/bin:/var/bin"' >> $(PKG_BUILD_DIR)/localoptions.h
endef
DROPBEAR_POST_CONFIGURE_HOOKS = DROPBEAR_CONFIGURE_LOCALOPTIONS

define DROPBEARMULTI_INSTALL_FILES
	cd $(TARGET_BIN_DIR) && ln -sf /usr/bin/dropbearmulti dropbear
	mkdir -p $(TARGET_DIR)/etc/dropbear
endef
DROPBEARMULTI_POST_FOLLOWUP_HOOKS += DROPBEARMULTI_INSTALL_FILES

$(D)/dropbearmulti:
	$(call autotools-package)
