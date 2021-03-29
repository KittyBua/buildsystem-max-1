#
# python-pyopenssl
#
PYTHON_PYOPENSSL_VERSION = 19.1.0
PYTHON_PYOPENSSL_DIR     = pyOpenSSL-$(PYTHON_PYOPENSSL_VERSION)
PYTHON_PYOPENSSL_SOURCE  = pyOpenSSL-$(PYTHON_PYOPENSSL_VERSION).tar.gz
PYTHON_PYOPENSSL_SITE    = https://pypi.python.org/packages/source/p/pyOpenSSL
PYTHON_PYOPENSSL_DEPENDS = bootstrap python python-setuptools

python-pyopenssl:
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
