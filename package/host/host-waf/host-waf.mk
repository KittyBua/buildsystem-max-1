################################################################################
#
# host-waf
#
################################################################################

HOST_WAF_VERSION = 2.0.24
HOST_WAF_DIR = waf-$(HOST_WAF_VERSION)
HOST_WAF_SOURCE = waf-$(HOST_WAF_VERSION)
HOST_WAF_SITE = https://waf.io

HOST_WAF_DEPENDS = host-python3

HOST_WAF_BINARY = $(HOST_DIR)/bin/waf

$(D)/host-waf: | bootstrap
	$(STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(CD) $(DL_DIR); \
		$(INSTALL_DATA) -D $(DL_DIR)/$(HOST_WAF_SOURCE) $(HOST_WAF_BINARY)
	$(TOUCH)
