#
# python-pyasn1
#
PYTHON_PYASN1_VER    = 0.3.6
PYTHON_PYASN1_DIR    = pyasn1-$(PYTHON_PYASN1_VER)
PYTHON_PYASN1_SOURCE = pyasn1-$(PYTHON_PYASN1_VER).tar.gz
PYTHON_PYASN1_SITE   = https://pypi.python.org/packages/source/p/pyasn1
PYTHON_PYASN1_DEPS   = bootstrap python python-setuptools python-pyasn1-modules

$(D)/python-pyasn1:
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
