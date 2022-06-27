################################################################################
#
# ca-bundle
#
################################################################################

CA_BUNDLE_VERSION = 1.0
CA_BUNDLE_DIR     = /etc/ssl/certs
CA_BUNDLE_SOURCE  = cacert.pem
CA_BUNDLE_SITE    = https://curl.se/ca
CA_BUNDLE_DEPENDS = bootstrap

CA_BUNDLE_CRT = ca-certificates.crt

define CA_BUNDLE_INSTALL_FILES
	$(INSTALL_DATA) -D $(DL_DIR)/$(CA_BUNDLE_SOURCE) $(TARGET_DIR)/$(CA_BUNDLE_DIR)/$(CA_BUNDLE_CRT)
endef
CA_BUNDLE_POST_FOLLOWUP_HOOKS += CA_BUNDLE_INSTALL_FILES

$(D)/ca-bundle:
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(CD) $(DL_DIR); \
		curl --silent --remote-name --remote-time -z $(CA_BUNDLE_SOURCE) $(CA_BUNDLE_SITE)/$(CA_BUNDLE_SOURCE) || true
	$(call TARGET_FOLLOWUP)
