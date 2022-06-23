################################################################################
#
# dvb-apps
#
################################################################################

DVB_APPS_VERSION = git
DVB_APPS_DIR     = dvb-apps.git
DVB_APPS_SOURCE  = dvb-apps.git
DVB_APPS_SITE    = https://github.com/openpli-arm
DVB_APPS_DEPENDS = bootstrap libiconv

define DVB_APPS_POST_PATCH
	$(SED) '/$$(MAKE) -C util $$@/d' $(PKG_BUILD_DIR)/Makefile
endef
DVB_APPS_POST_PATCH_HOOKS = DVB_APPS_POST_PATCH

DVB_APPS_LDLIBS = -liconv

DVB_APPS_MAKE_OPTS = \
	PERL5LIB=$(PKG_BUILD_DIR)/util/scan \
	enable_shared=no

$(D)/dvb-apps:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE_ENV) LDLIBS="$(DVB_APPS_LDLIBS)" \
		$(MAKE) CROSS_ROOT=$(CROSS_ROOT_DIR) $(DVB_APPS_MAKE_OPTS); \
		$(MAKE) $(DVB_APPS_MAKE_OPTS) install DESTDIR=$(TARGET_DIR)
	$(call TARGET_FOLLOWUP)
