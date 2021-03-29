#
# pugixml
#
PUGIXML_VERSION = 1.10
PUGIXML_DIR     = pugixml-$(PUGIXML_VERSION)
PUGIXML_SOURCE  = pugixml-$(PUGIXML_VERSION).tar.gz
PUGIXML_SITE    = https://github.com/zeux/pugixml/releases/download/v$(PUGIXML_VERSION)
PUGIXML_DEPENDS = bootstrap

PUGIXML_CONF_OPTS = \
	| tail -n +90

pugixml:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(TARGET_CMAKE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	rm -rf $(addprefix $(TARGET_DIR)/usr/lib/,cmake)
	$(TOUCH)
