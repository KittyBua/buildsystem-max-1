#
# ca-bundle
#
CA_BUNDLE_SOURCE = cacert.pem
CA_BUNDLE_URL    = https://curl.haxx.se/ca

$(D)/ca-bundle:
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	cd $(DL_DIR); \
		curl --silent --remote-name --time-cond $(CA_BUNDLE_SOURCE) $(CA_BUNDLE_URL)/$(CA-BUNDLE_SOURCE) || true
	$(INSTALL_DATA) -D $(DL_DIR)/$(CA_BUNDLE_SOURCE) $(TARGET_DIR)/$(CA_BUNDLE_DIR)/$(CA_BUNDLE)
	$(TOUCH)
