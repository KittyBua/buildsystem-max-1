################################################################################
#
# host-python
#
################################################################################

HOST_PYTHON_VERSION = 2.7.18
HOST_PYTHON_DIR     = Python-$(HOST_PYTHON_VERSION)
HOST_PYTHON_SOURCE  = Python-$(HOST_PYTHON_VERSION).tar.xz
HOST_PYTHON_SITE    = https://www.python.org/ftp/python/$(HOST_PYTHON_VERSION)
HOST_PYTHON_DEPENDS = bootstrap

HOST_PYTHON_BINARY = $(HOST_DIR)/bin/python2

HOST_PYTHON_LIB_DIR     = lib/python$(basename $(HOST_PYTHON_VERSION))
HOST_PYTHON_INCLUDE_DIR = include/python$(basename $(HOST_PYTHON_VERSION))
HOST_PYTHON_SITEPACKAGES_DIR = $(HOST_PYTHON_LIB_DIR)/site-packages

HOST_PYTHON_AUTORECONF = YES

HOST_PYTHON_CONF_OPTS = \
	--without-cxx-main \
	--with-threads

$(D)/host-python:
	$(call PREPARE)
	$(call HOST_CONFIGURE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) python Parser/pgen; \
		mv python ./hostpython; \
		mv Parser/pgen ./hostpgen; \
		cp ./hostpgen $(HOST_DIR)/bin/pgen; \
		$(MAKE) distclean
	$(call HOST_CONFIGURE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE); \
		$(MAKE) install
	$(call TARGET_FOLLOWUP)
