#
# python-pyasn1
#
PYTHON_PYASN1_VER    = 0.3.6
PYTHON_PYASN1_DIR    = pyasn1-$(PYTHON_PYASN1_VER)
PYTHON_PYASN1_SOURCE = pyasn1-$(PYTHON_PYASN1_VER).tar.gz
PYTHON_PYASN1_SITE   = https://pypi.python.org/packages/source/p/pyasn1

$(D)/python-pyasn1: bootstrap python python-setuptools python-pyasn1-modules
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(PKG_REMOVE)
	$(TOUCH)
