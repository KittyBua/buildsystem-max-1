################################################################################
#
# pugixml
#
################################################################################

PUGIXML_VERSION = 1.12.1
PUGIXML_DIR     = pugixml-$(basename $(PUGIXML_VERSION))
PUGIXML_SOURCE  = pugixml-$(PUGIXML_VERSION).tar.gz
PUGIXML_SITE    = https://github.com/zeux/pugixml/releases/download/v$(PUGIXML_VERSION)
PUGIXML_DEPENDS = bootstrap

PUGIXML_CONF_OPTS = \
	-DBUILD_DEFINES="PUGIXML_HAS_LONG_LONG" \
	| tail -n +90

$(D)/pugixml:
	$(call cmake-package)
