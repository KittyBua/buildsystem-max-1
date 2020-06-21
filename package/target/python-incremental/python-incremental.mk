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
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
