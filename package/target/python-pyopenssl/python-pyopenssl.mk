#
# python-pyopenssl
#
PYTHON_PYOPENSSL_VER    = 19.1.0
PYTHON_PYOPENSSL_DIR    = pyOpenSSL-$(PYTHON_PYOPENSSL_VER)
PYTHON_PYOPENSSL_SOURCE = pyOpenSSL-$(PYTHON_PYOPENSSL_VER).tar.gz
PYTHON_PYOPENSSL_URL    = https://pypi.python.org/packages/source/p/pyOpenSSL

$(D)/python-pyopenssl: bootstrap python python-setuptools
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
