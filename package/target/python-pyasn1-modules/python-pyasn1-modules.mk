#
# python-pyasn1-modules
#
PYTHON_PYASN1_MODULES_VERSION = 0.1.4
PYTHON_PYASN1_MODULES_DIR     = pyasn1-modules-$(PYTHON_PYASN1_MODULES_VERSION)
PYTHON_PYASN1_MODULES_SOURCE  = pyasn1-modules-$(PYTHON_PYASN1_MODULES_VERSION).tar.gz
PYTHON_PYASN1_MODULES_SITE    = https://pypi.python.org/packages/source/p/pyasn1-modules
PYTHON_PYASN1_MODULES_DEPENDS = bootstrap python python-setuptools

python-pyasn1-modules:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)
	$(TOUCH)
