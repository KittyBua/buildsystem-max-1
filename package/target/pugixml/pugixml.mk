#
# pugixml
#
PUGIXML_VER    = 1.10
PUGIXML_DIR    = pugixml-$(PUGIXML_VER)
PUGIXML_SOURCE = pugixml-$(PUGIXML_VER).tar.gz
PUGIXML_SITE   = https://github.com/zeux/pugixml/releases/download/v$(PUGIXML_VER)

PUGIXML_PATCH  = \
	0001-pugixml-config.patch

$(D)/pugixml: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CMAKE) \
			| tail -n +90 \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	cd $(TARGET_DIR) && rm -rf usr/lib/cmake
	$(PKG_REMOVE)
	$(TOUCH)
