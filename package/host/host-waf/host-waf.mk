################################################################################
#
# waf
#
################################################################################

HOST_WAF_VERSION = 2.0.22
HOST_WAF_DIR = waf-$(HOST_WAF_VERSION)
HOST_WAF_SOURCE = waf-$(HOST_WAF_VERSION)
HOST_WAF_SITE = https://waf.io

HOST_WAF_DEPENDS = bootstrap host-python3

HOST_WAF_BINARY = $(HOST_DIR)/bin/waf

$(D)/host-waf:
	$(STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	cd $(DL_DIR); \
		$(INSTALL_DATA) -D $(DL_DIR)/$(HOST_WAF_SOURCE) $(HOST_WAF_BINARY)
	$(TOUCH)
