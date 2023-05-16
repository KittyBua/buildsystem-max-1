################################################################################
#
# ca-bundle
#
################################################################################

CA_BUNDLE_VERSION = 1.0
CA_BUNDLE_DIR = /etc/ssl/certs
CA_BUNDLE_SOURCE = cacert.pem
CA_BUNDLE_SITE = https://curl.se/ca
CA_BUNDLE_SITE_METHOD = curl

CA_BUNDLE_CERT = ca-certificates.crt

define CA_BUNDLE_INSTALL
	$(INSTALL_DATA) -D $(DL_DIR)/$($(PKG)_SOURCE) $(TARGET_DIR)/$(CA_BUNDLE_DIR)/$(CA_BUNDLE_CERT)
endef
CA_BUNDLE_POST_FOLLOWUP_HOOKS += CA_BUNDLE_INSTALL

$(D)/ca-bundle: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call TARGET_FOLLOWUP)
