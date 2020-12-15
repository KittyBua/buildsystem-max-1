#
# openthreads
#
OPENTHREADS_VER    = 3.2
OPENTHREADS_DIR    = OpenThreads-$(OPENTHREADS_VER)
OPENTHREADS_SOURCE = OpenThreads-$(OPENTHREADS_VER).tar.gz
OPENTHREADS_SITE   = https://sourceforge.net/projects/mxedeps/files

OPENTHREADS_CONF_OPTS = \
	-DCMAKE_SUPPRESS_DEVELOPER_WARNINGS="1" \
	-D_OPENTHREADS_ATOMIC_USE_GCC_BUILTINS_EXITCODE="0" \
	-D_OPENTHREADS_ATOMIC_USE_GCC_BUILTINS_EXITCODE__TRYRUN_OUTPUT="1" \
	| tail -n +90

$(D)/openthreads: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		echo "# dummy file to prevent warning message" > examples/CMakeLists.txt; \
		$(CMAKE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
