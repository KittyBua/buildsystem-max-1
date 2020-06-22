#
# python-pyopenssl
#
PYTHON_PYOPENSSL_VER    = 19.1.0
PYTHON_PYOPENSSL_DIR    = pyOpenSSL-$(PYTHON_PYOPENSSL_VER)
PYTHON_PYOPENSSL_SOURCE = pyOpenSSL-$(PYTHON_PYOPENSSL_VER).tar.gz
PYTHON_PYOPENSSL_SITE   = https://pypi.python.org/packages/source/p/pyOpenSSL

$(D)/python-pyopenssl: bootstrap python python-setuptools
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(PKG_REMOVE)
	$(TOUCH)
