################################################################################
#
# python-setuptools
#
################################################################################

PYTHON_SETUPTOOLS_VERSION = 5.2
PYTHON_SETUPTOOLS_DIR = setuptools-$(PYTHON_SETUPTOOLS_VERSION)
PYTHON_SETUPTOOLS_SOURCE = setuptools-$(PYTHON_SETUPTOOLS_VERSION).tar.gz
PYTHON_SETUPTOOLS_SITE = https://pypi.python.org/packages/source/s/setuptools

PYTHON_SETUPTOOLS_DEPENDS = bootstrap python

$(D)/python-setuptools:
	$(call target-python-package)
