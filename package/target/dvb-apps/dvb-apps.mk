#
# dvb-apps
#
DVB_APPS_VER    = git
DVB_APPS_DIR    = dvb-apps.git
DVB_APPS_SOURCE = dvb-apps.git
DVB_APPS_SITE   = https://github.com/openpli-arm
DVB_APPS_DEPS   = bootstrap

$(D)/dvb-apps:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		export PERL_USE_UNSAFE_INC=1; \
		export enable_shared="no"; \
		$(BUILD_ENV) \
		$(MAKE) DESTDIR=$(TARGET_DIR); \
		$(MAKE) DESTDIR=$(TARGET_DIR) install
	$(PKG_REMOVE)
	$(TOUCH)
