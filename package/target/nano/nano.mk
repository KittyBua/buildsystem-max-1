#
# nano
#
NANO_VER    = 2.2.6
NANO_DIR    = nano-$(NANO_VER)
NANO_SOURCE = nano-$(NANO_VER).tar.gz
NANO_SITE   = https://www.nano-editor.org/dist/v$(basename $(NANO_VER))
NANO_DEPS   = bootstrap

NANO_CONF_OPTS = \
	--localedir=$(REMOVE_localedir) \
	--disable-nls \
	--enable-tiny \
	--enable-color

$(D)/nano:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
