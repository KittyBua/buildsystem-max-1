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
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
