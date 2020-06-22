#
# python-pyasn1-modules
#
PYTHON_PYASN1_MODULES_VER    = 0.1.4
PYTHON_PYASN1_MODULES_DIR    = pyasn1-modules-$(PYTHON_PYASN1_MODULES_VER)
PYTHON_PYASN1_MODULES_SOURCE = pyasn1-modules-$(PYTHON_PYASN1_MODULES_VER).tar.gz
PYTHON_PYASN1_MODULES_SITE   = https://pypi.python.org/packages/source/p/pyasn1-modules

$(D)/python-pyasn1-modules: bootstrap python python-setuptools
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(PKG_REMOVE)
	$(TOUCH)
