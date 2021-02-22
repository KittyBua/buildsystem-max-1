#
# pugixml
#
PUGIXML_VER    = 1.10
PUGIXML_DIR    = pugixml-$(PUGIXML_VER)
PUGIXML_SOURCE = pugixml-$(PUGIXML_VER).tar.gz
PUGIXML_SITE   = https://github.com/zeux/pugixml/releases/download/v$(PUGIXML_VER)
PUGIXML_DEPS   = bootstrap

PUGIXML_CONF_OPTS = \
	| tail -n +90

$(D)/pugixml:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CMAKE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	cd $(TARGET_DIR) && rm -rf usr/lib/cmake
	$(REMOVE)
	$(TOUCH)
