#
# python-incremental
#
PYTHON_INCREMENTAL_VER    = 17.5.0
PYTHON_INCREMENTAL_DIR    = incremental-$(PYTHON_INCREMENTAL_VER)
PYTHON_INCREMENTAL_SOURCE = incremental-$(PYTHON_INCREMENTAL_VER).tar.gz
PYTHON_INCREMENTAL_SITE   = https://files.pythonhosted.org/packages/source/i/incremental

$(D)/python-incremental: bootstrap python python-setuptools
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(PKG_REMOVE)
	$(TOUCH)
