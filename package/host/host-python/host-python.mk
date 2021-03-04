#
# host-python
#
HOST_PYTHON_VER    = 2.7.18
HOST_PYTHON_DIR    = Python-$(HOST_PYTHON_VER)
HOST_PYTHON_SOURCE = Python-$(HOST_PYTHON_VER).tar.xz
HOST_PYTHON_SITE   = https://www.python.org/ftp/python/$(HOST_PYTHON_VER)
HOST_PYTHON_DEPS   = bootstrap

HOST_PYTHON_AUTORECONF = YES

HOST_PYTHON_CONF_OPTS = \
	--without-cxx-main \
	--with-threads

$(D)/host-python:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(HOST_CONFIGURE); \
		$(MAKE) python Parser/pgen; \
		mv python ./hostpython; \
		mv Parser/pgen ./hostpgen; \
		cp ./hostpgen $(HOST_DIR)/bin/pgen; \
		$(MAKE) distclean; \
		$(HOST_CONFIGURE); \
		$(MAKE); \
		$(MAKE) install
	$(REMOVE)
	$(TOUCH)
