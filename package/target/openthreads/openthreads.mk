################################################################################
#
# openthreads
#
################################################################################

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

define OPENTHREADS_CREATE_CONF_ENV_FILE
	echo "# dummy file to prevent warning message" > $(PKG_BUILD_DIR)/examples/CMakeLists.txt
endef
OPENTHREADS_POST_PATCH_HOOKS += OPENTHREADS_CREATE_CONF_ENV_FILE

$(D)/openthreads:
	$(call cmake-package)
