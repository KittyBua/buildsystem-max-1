################################################################################
#
# CMake package infrastructure
#
################################################################################

CMAKE_QUIET = -DCMAKE_RULE_MESSAGES=OFF -DCMAKE_INSTALL_MESSAGE=NEVER

TARGET_CMAKE_ENV = \
	$($(PKG)_CONF_ENV)

TARGET_CMAKE_OPTS = \
	--no-warn-unused-cli

TARGET_CMAKE_OPTS += \
	$(CMAKE_QUIET) \
	-DENABLE_STATIC=OFF \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_DOC=OFF \
	-DBUILD_DOCS=OFF \
	-DBUILD_EXAMPLE=OFF \
	-DBUILD_EXAMPLES=OFF \
	-DBUILD_TEST=OFF \
	-DBUILD_TESTS=OFF \
	-DBUILD_TESTING=OFF \
	-DCMAKE_COLOR_MAKEFILE=OFF \
	-DCMAKE_BUILD_TYPE="Release" \
	-DCMAKE_SYSTEM_NAME="Linux" \
	-DCMAKE_SYSTEM_PROCESSOR="$(TARGET_ARCH)" \
	-DCMAKE_INSTALL_PREFIX="$(prefix)" \
	-DCMAKE_INSTALL_DOCDIR="$(REMOVE_docdir)" \
	-DCMAKE_INSTALL_MANDIR="$(REMOVE_mandir)" \
	-DCMAKE_PREFIX_PATH="$(TARGET_DIR)" \
	-DCMAKE_LIBRARY_PATH="$(TARGET_LIB_DIR)" \
	-DCMAKE_INCLUDE_PATH="$(TARGET_INCLUDE_DIR)" \
	-DCMAKE_C_COMPILER="$(TARGET_CC)" \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -DNDEBUG" \
	-DCMAKE_CXX_COMPILER="$(TARGET_CXX)" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CFLAGS) -DNDEBUG" \
	-DCMAKE_STRIP="$(TARGET_STRIP)"

TARGET_CMAKE_OPTS += \
	$($(PKG)_CONF_OPTS)

define TARGET_CMAKE
	@$(call MESSAGE,"Configuring")
	$(foreach hook,$($(PKG)_PRE_CONFIGURE_HOOKS),$(call $(hook))$(sep))
	$(Q)( \
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
		rm -f CMakeCache.txt; \
		mkdir -p build; \
		cd build; \
		$(TARGET_CMAKE_ENV) $($(PKG)_CONF_ENV) \
		cmake .. \
			$(TARGET_CMAKE_OPTS) $($(PKG)_CONF_OPTS); \
	)
	$(foreach hook,$($(PKG)_POST_CONFIGURE_HOOKS),$(call $(hook))$(sep))
endef

define cmake-package
	$(call PREPARE)
	$(call TARGET_CMAKE)
	$(call TARGET_MAKE,/build)
	$(call TARGET_MAKE_INSTALL,/build)
	$(call TARGET_FOLLOWUP)
endef

################################################################################
#
# Host CMake package infrastructure
#
################################################################################

HOST_CMAKE_ENV = \
	$($(PKG)_CONF_ENV)

HOST_CMAKE_OPTS += \
	--no-warn-unused-cli

HOST_CMAKE_OPTS += \
	$(CMAKE_QUIET) \
	-DENABLE_STATIC=OFF \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_DOC=OFF \
	-DBUILD_DOCS=OFF \
	-DBUILD_EXAMPLE=OFF \
	-DBUILD_EXAMPLES=OFF \
	-DBUILD_TEST=OFF \
	-DBUILD_TESTS=OFF \
	-DBUILD_TESTING=OFF \
	-DCMAKE_COLOR_MAKEFILE=OFF \
	-DCMAKE_INSTALL_PREFIX="$(HOST_DIR)" \
	-DCMAKE_PREFIX_PATH="$(HOST_DIR)"

HOST_CMAKE_OPTS += \
	$($(PKG)_CONF_OPTS)

define HOST_CMAKE
	@$(call MESSAGE,"Configuring")
	$(foreach hook,$($(PKG)_PRE_CONFIGURE_HOOKS),$(call $(hook))$(sep))
	$(Q)( \
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
		rm -f CMakeCache.txt; \
		mkdir -p build; \
		cd build; \
		$(HOST_CMAKE_ENV) $($(PKG)_CONF_ENV) \
		cmake .. \
			$(HOST_CMAKE_OPTS) $($(PKG)_CONF_OPTS); \
	)
	$(foreach hook,$($(PKG)_POST_CONFIGURE_HOOKS),$(call $(hook))$(sep))
endef

define host-cmake-package
	$(call PREPARE)
	$(call HOST_CMAKE)
	$(call HOST_MAKE,/build)
	$(call HOST_MAKE_INSTALL,/build)
	$(call HOST_FOLLOWUP)
endef
