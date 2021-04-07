#
# nano
#
NANO_VERSION = 2.2.6
NANO_DIR     = nano-$(NANO_VERSION)
NANO_SOURCE  = nano-$(NANO_VERSION).tar.gz
NANO_SITE    = https://www.nano-editor.org/dist/v$(basename $(NANO_VERSION))
NANO_DEPENDS = bootstrap

NANO_CONF_OPTS = \
	--localedir=$(REMOVE_localedir) \
	--disable-nls \
	--enable-tiny \
	--enable-color

$(D)/nano:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
