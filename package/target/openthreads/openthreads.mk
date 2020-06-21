#
# openthreads
#
OPENTHREADS_VER    = 3.2
OPENTHREADS_DIR    = OpenThreads-$(OPENTHREADS_VER)
OPENTHREADS_SOURCE = OpenThreads-$(OPENTHREADS_VER).tar.gz
OPENTHREADS_SITE   = https://sourceforge.net/projects/mxedeps/files

$(D)/openthreads: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		echo "# dummy file to prevent warning message" > examples/CMakeLists.txt; \
		$(CMAKE) \
			-DCMAKE_SUPPRESS_DEVELOPER_WARNINGS="1" \
			-D_OPENTHREADS_ATOMIC_USE_GCC_BUILTINS_EXITCODE="0" \
			-D_OPENTHREADS_ATOMIC_USE_GCC_BUILTINS_EXITCODE__TRYRUN_OUTPUT="1" \
			| tail -n +90 \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
