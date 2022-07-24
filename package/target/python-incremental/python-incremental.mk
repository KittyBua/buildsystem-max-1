################################################################################
#
# python-incremental
#
################################################################################

PYTHON_INCREMENTAL_VERSION = 17.5.0
PYTHON_INCREMENTAL_DIR = incremental-$(PYTHON_INCREMENTAL_VERSION)
PYTHON_INCREMENTAL_SOURCE = incremental-$(PYTHON_INCREMENTAL_VERSION).tar.gz
PYTHON_INCREMENTAL_SITE = https://files.pythonhosted.org/packages/source/i/incremental

PYTHON_INCREMENTAL_DEPENDS = python python-setuptools

$(D)/python-incremental: | bootstrap
	$(call python-package)
