#
# python-service-identity
#
PYTHON_SERVICE_IDENTITY_VER    = 17.0.0
PYTHON_SERVICE_IDENTITY_DIR    = service_identity-$(PYTHON_SERVICE_IDENTITY_VER)
PYTHON_SERVICE_IDENTITY_SOURCE = service_identity-$(PYTHON_SERVICE_IDENTITY_VER).tar.gz
PYTHON_SERVICE_IDENTITY_SITE   = https://pypi.python.org/packages/source/s/service_identity

$(D)/python-service-identity: bootstrap python python-setuptools python-attr python-attrs python-pyasn1
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(PKG_REMOVE)
	$(TOUCH)
