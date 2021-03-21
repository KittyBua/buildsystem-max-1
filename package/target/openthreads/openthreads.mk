#
# openthreads
#
OPENTHREADS_VERSION = 3.2
OPENTHREADS_DIR     = OpenThreads-$(OPENTHREADS_VERSION)
OPENTHREADS_SOURCE  = OpenThreads-$(OPENTHREADS_VERSION).tar.gz
OPENTHREADS_SITE    = https://sourceforge.net/projects/mxedeps/files
OPENTHREADS_DEPENDS = bootstrap

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
	$(CD_BUILD_DIR); \
		echo "# dummy file to prevent warning message" > examples/CMakeLists.txt; \
		$(CMAKE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
