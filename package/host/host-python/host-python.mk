#
# host-python
#
HOST_PYTHON_VER    = 2.7.18
HOST_PYTHON_DIR    = Python-$(HOST_PYTHON_VER)
HOST_PYTHON_SOURCE = Python-$(HOST_PYTHON_VER).tar.xz
HOST_PYTHON_SITE   = https://www.python.org/ftp/python/$(HOST_PYTHON_VER)

HOST_PYTHON_PATCH  = \
	0001-python.patch

$(D)/host-python: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoconf; \
		CONFIG_SITE= \
		OPT="$(HOST_CFLAGS)" \
		./configure $(SILENT_OPT) \
			--without-cxx-main \
			--with-threads \
			; \
		$(MAKE) python Parser/pgen; \
		mv python ./hostpython; \
		mv Parser/pgen ./hostpgen; \
		\
		$(MAKE) distclean; \
		./configure $(SILENT_OPT) \
			--prefix=$(HOST_DIR) \
			--sysconfdir=$(HOST_DIR)/etc \
			--without-cxx-main \
			--with-threads \
			; \
		$(MAKE) all install; \
		cp ./hostpgen $(HOST_DIR)/bin/pgen
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
