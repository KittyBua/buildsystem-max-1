#
# dvb-apps
#
DVB_APPS_VER    = git
DVB_APPS_DIR    = dvb-apps.git
DVB_APPS_SOURCE = dvb-apps.git
DVB_APPS_SITE   = https://github.com/openpli-arm
DVB_APPS_DEPS   = bootstrap libiconv

define DVB_APPS_POST_PATCH
	$(SED) '/$$(MAKE) -C util $$@/d' $(PKG_BUILD_DIR)/Makefile
endef
DVB_APPS_POST_PATCH_HOOKS = DVB_APPS_POST_PATCH

DVB_APPS_LDLIBS = -liconv

DVB_APPS_MAKE_OPTS  = PERL5LIB=$(PKG_BUILD_DIR)/util/scan
DVB_APPS_MAKE_OPTS += enable_shared=no

$(D)/dvb-apps:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(TARGET_CONFIGURE_ENV) LDLIBS="$(DVB_APPS_LDLIBS)" \
		$(MAKE) CROSS_ROOT=$(STAGING_DIR) $(DVB_APPS_MAKE_OPTS); \
		$(MAKE) $(DVB_APPS_MAKE_OPTS) DESTDIR=$(TARGET_DIR) install
	$(REMOVE)
	$(TOUCH)
