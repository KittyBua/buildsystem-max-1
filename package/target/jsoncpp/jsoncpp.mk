################################################################################
#
# jsoncpp
#
################################################################################

JSONCPP_VERSION = 1.9.5
JSONCPP_DIR = jsoncpp-$(JSONCPP_VERSION)
JSONCPP_SOURCE = jsoncpp-$(JSONCPP_VERSION).tar.gz
JSONCPP_SITE = $(call github,open-source-parsers,jsoncpp,$(JSONCPP_VERSION))

##JSONCPP_DEPENDS = host-meson

JSONCPP_CONF_OPTS = \
	-Dtests=false

$(D)/jsoncpp: | bootstrap
	$(call meson-package)
