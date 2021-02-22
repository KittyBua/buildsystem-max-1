#
# python-service-identity
#
PYTHON_SERVICE_IDENTITY_VER    = 17.0.0
PYTHON_SERVICE_IDENTITY_DIR    = service_identity-$(PYTHON_SERVICE_IDENTITY_VER)
PYTHON_SERVICE_IDENTITY_SOURCE = service_identity-$(PYTHON_SERVICE_IDENTITY_VER).tar.gz
PYTHON_SERVICE_IDENTITY_SITE   = https://pypi.python.org/packages/source/s/service_identity
PYTHON_SERVICE_IDENTITY_DEPS   = bootstrap python python-setuptools python-attr python-attrs python-pyasn1

$(D)/python-service-identity:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)
	$(TOUCH)
