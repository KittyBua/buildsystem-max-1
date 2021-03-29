#
# python-incremental
#
PYTHON_INCREMENTAL_VERSION = 17.5.0
PYTHON_INCREMENTAL_DIR     = incremental-$(PYTHON_INCREMENTAL_VERSION)
PYTHON_INCREMENTAL_SOURCE  = incremental-$(PYTHON_INCREMENTAL_VERSION).tar.gz
PYTHON_INCREMENTAL_SITE    = https://files.pythonhosted.org/packages/source/i/incremental
PYTHON_INCREMENTAL_DEPENDS = bootstrap python python-setuptools

python-incremental:
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
