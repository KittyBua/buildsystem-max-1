#
# openthreads
#
OPENTHREADS_VER    = 3.2
OPENTHREADS_DIR    = OpenThreads-$(OPENTHREADS_VER)
OPENTHREADS_SOURCE = OpenThreads-$(OPENTHREADS_VER).tar.gz
OPENTHREADS_SITE   = https://sourceforge.net/projects/mxedeps/files
OPENTHREADS_DEPS   = bootstrap

OPENTHREADS_CONF_OPTS = \
	-DCMAKE_SUPPRESS_DEVELOPER_WARNINGS="1" \
	-D_OPENTHREADS_ATOMIC_USE_GCC_BUILTINS_EXITCODE="0" \
	-D_OPENTHREADS_ATOMIC_USE_GCC_BUILTINS_EXITCODE__TRYRUN_OUTPUT="1" \
	| tail -n +90

$(D)/openthreads:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(PKG_CHDIR); \
		echo "# dummy file to prevent warning message" > examples/CMakeLists.txt; \
		$(CMAKE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
