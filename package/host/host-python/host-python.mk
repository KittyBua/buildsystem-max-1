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

HOST_PYTHON_AUTORECONF = YES

HOST_PYTHON_CONF_OPTS = \
	--without-cxx-main \
	--with-threads

$(D)/host-python:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(HOST_CONFIGURE); \
		$(MAKE) python Parser/pgen; \
		mv python ./hostpython; \
		mv Parser/pgen ./hostpgen; \
		cp ./hostpgen $(HOST_DIR)/bin/pgen; \
		$(MAKE) distclean; \
		$(HOST_CONFIGURE); \
		$(MAKE); \
		$(MAKE) install
	$(call TARGET_FOLLOWUP)
