################################################################################
#
# dvb-apps
#
################################################################################

DVB_APPS_VERSION = git
DVB_APPS_DIR = dvb-apps.git
DVB_APPS_SOURCE = dvb-apps.git
DVB_APPS_SITE = https://github.com/openpli-arm

DVB_APPS_DEPENDS = libiconv

define DVB_APPS_POST_PATCH
	$(SED) '/$$(MAKE) -C util $$@/d' $(PKG_BUILD_DIR)/Makefile
endef
DVB_APPS_POST_PATCH_HOOKS = DVB_APPS_POST_PATCH

DVB_APPS_LDLIBS = \
	-liconv

DVB_APPS_MAKE_ENV = \
	$(TARGET_CONFIGURE_ENV) \
	LDLIBS="$(DVB_APPS_LDLIBS)"

DVB_APPS_MAKE_OPTS = \
	KERNEL_HEADERS=$(KERNEL_HEADERS_DIR) \
	PERL5LIB=$(PKG_BUILD_DIR)/util/scan \
	enable_shared=no

DVB_APPS_MAKE_INSTALL_OPTS = \
	$(DVB_APPS_MAKE_OPTS)

$(D)/dvb-apps: | bootstrap
	$(call generic-package)
