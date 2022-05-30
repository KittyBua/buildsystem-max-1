################################################################################
#
# openssh
#
################################################################################

OPENSSH_VERSION = 9.0p1
OPENSSH_DIR     = openssh-$(OPENSSH_VERSION)
OPENSSH_SOURCE  = openssh-$(OPENSSH_VERSION).tar.gz
OPENSSH_SITE    = https://artfiles.org/openbsd/OpenSSH/portable
OPENSSH_DEPENDS = bootstrap zlib openssl

OPENSSH_AUTORECONF = YES

OPENSSH_CONF_ENV = \
	ac_cv_search_dlopen=no

OPENSSH_CONF_OPTS = \
	--sysconfdir=/etc/ssh \
	--libexecdir=$(base_sbindir) \
	--with-pid-dir=/tmp \
	--with-privsep-path=/var/empty \
	--with-cppflags="-pipe -Os -I$(TARGET_INCLUDE_DIR)" \
	--with-ldflags="-L$(TARGET_LIB_DIR)" \
	--disable-strip \
	--disable-lastlog \
	--disable-utmp \
	--disable-utmpx \
	--disable-wtmp \
	--disable-wtmpx \
	--disable-pututline \
	--disable-pututxline

define OPENSSH_INSTALL_INIT_SYSV
	$(INSTALL_EXEC) $(BUILD_DIR)/openssh-$(OPENSSH_VERSION)/opensshd.init $(TARGET_DIR)/etc/init.d/openssh
endef

define OPENSSH_INSTALL_FILES
	$(SED) 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' $(TARGET_DIR)/etc/ssh/sshd_config
endef
OPENSSH_POST_INSTALL_TARGET_HOOKS += OPENSSH_INSTALL_FILES

$(D)/openssh:
	$(call make-package)
