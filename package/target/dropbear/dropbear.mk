#
# dropbear
#
DROPBEAR_VER    = 2018.76
DROPBEAR_DIR    = dropbear-$(DROPBEAR_VER)
DROPBEAR_SOURCE = dropbear-$(DROPBEAR_VER).tar.bz2
DROPBEAR_SITE   = http://matt.ucc.asn.au/dropbear/releases
DROPBEAR_DEPS   = bootstrap zlib

define DROPBEAR_POST_PATCH
	$(SED) 's|^\(#define DROPBEAR_SMALL_CODE\).*|\1 0|' $(PKG_BUILD_DIR)/default_options.h
endef
DROPBEAR_POST_PATCH_HOOKS = DROPBEAR_POST_PATCH

DROPBEAR_CONF_OPTS = \
	--disable-pututxline \
	--disable-wtmp \
	--disable-wtmpx \
	--disable-loginfunc \
	--disable-pam 

$(D)/dropbear:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE) PROGRAMS="dropbear dbclient dropbearkey scp" SCPPROGRESS=1; \
		$(MAKE) PROGRAMS="dropbear dbclient dropbearkey scp" install DESTDIR=$(TARGET_DIR)
	mkdir -p $(TARGET_DIR)/etc/dropbear
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/dropbear $(TARGET_DIR)/etc/init.d/
	$(REMOVE)
	$(TOUCH)
