#
# python-service-identity
#
PYTHON_SERVICE_IDENTITY_VER    = 17.0.0
PYTHON_SERVICE_IDENTITY_DIR    = service_identity-$(PYTHON_SERVICE_IDENTITY_VER)
PYTHON_SERVICE_IDENTITY_SOURCE = service_identity-$(PYTHON_SERVICE_IDENTITY_VER).tar.gz
PYTHON_SERVICE_IDENTITY_SITE   = https://pypi.python.org/packages/source/s/service_identity

$(D)/python-service-identity: bootstrap python python-setuptools python-attr python-attrs python-pyasn1
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
