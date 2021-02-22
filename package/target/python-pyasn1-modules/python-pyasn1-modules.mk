#
# python-pyasn1-modules
#
PYTHON_PYASN1_MODULES_VER    = 0.1.4
PYTHON_PYASN1_MODULES_DIR    = pyasn1-modules-$(PYTHON_PYASN1_MODULES_VER)
PYTHON_PYASN1_MODULES_SOURCE = pyasn1-modules-$(PYTHON_PYASN1_MODULES_VER).tar.gz
PYTHON_PYASN1_MODULES_SITE   = https://pypi.python.org/packages/source/p/pyasn1-modules
PYTHON_PYASN1_MODULES_DEPS   = bootstrap python python-setuptools

$(D)/python-pyasn1-modules:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)
	$(TOUCH)
