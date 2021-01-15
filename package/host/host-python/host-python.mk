#
# host-python
#
HOST_PYTHON_VER    = 2.7.18
HOST_PYTHON_DIR    = Python-$(HOST_PYTHON_VER)
HOST_PYTHON_SOURCE = Python-$(HOST_PYTHON_VER).tar.xz
HOST_PYTHON_SITE   = https://www.python.org/ftp/python/$(HOST_PYTHON_VER)
HOST_PYTHON_DEPS   = bootstrap

$(D)/host-python:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		autoconf; \
		CONFIG_SITE= \
		OPT="$(HOST_CFLAGS)" \
		./configure \
			--without-cxx-main \
			--with-threads \
			; \
		$(MAKE) python Parser/pgen; \
		mv python ./hostpython; \
		mv Parser/pgen ./hostpgen; \
		\
		$(MAKE) distclean; \
		./configure \
			--prefix=$(HOST_DIR) \
			--sysconfdir=$(HOST_DIR)/etc \
			--without-cxx-main \
			--with-threads \
			; \
		$(MAKE); \
		$(MAKE) install; \
		cp ./hostpgen $(HOST_DIR)/bin/pgen
	$(PKG_REMOVE)
	$(TOUCH)
