#
# python-pyopenssl
#
PYTHON_PYOPENSSL_VER    = 19.1.0
PYTHON_PYOPENSSL_DIR    = pyOpenSSL-$(PYTHON_PYOPENSSL_VER)
PYTHON_PYOPENSSL_SOURCE = pyOpenSSL-$(PYTHON_PYOPENSSL_VER).tar.gz
PYTHON_PYOPENSSL_SITE   = https://pypi.python.org/packages/source/p/pyOpenSSL
PYTHON_PYOPENSSL_DEPS   = bootstrap python python-setuptools

$(D)/python-pyopenssl:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)
	$(TOUCH)
