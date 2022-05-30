################################################################################
#
# CMake package infrastructure
#
################################################################################

#CMAKE_QUIET = -DCMAKE_RULE_MESSAGES=OFF -DCMAKE_INSTALL_MESSAGE=NEVER

TARGET_CMAKE_OPTS = \
	$($(PKG)_CONF_ENV)

TARGET_CMAKE_OPTIONS = \
	--no-warn-unused-cli \
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
	-DCMAKE_STRIP="$(TARGET_STRIP)" \
	$(CMAKE_QUIET) \
	$($(PKG)_CONF_OPTS)

TARGET_CMAKE = \
	rm -f CMakeCache.txt; \
	mkdir -p build; \
	cd build; \
	$(TARGET_CMAKE_OPTS) cmake .. $(TARGET_CMAKE_OPTIONS)

define cmake-package
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CMAKE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -rf $(addprefix $(TARGET_LIB_DIR)/,cmake)
	$(call TARGET_FOLLOWUP)
endef

# -----------------------------------------------------------------------------

HOST_CMAKE_ENV = \
	$($(PKG)_CONF_ENV)

HOST_CMAKE_OPTS += \
	--no-warn-unused-cli

HOST_CMAKE_OPTS += \
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
	-DCMAKE_PREFIX_PATH="$(HOST_DIR)" \
	$(CMAKE_QUIET) \
	$($(PKG)_CONF_OPTS)

HOST_CMAKE = \
	rm -f CMakeCache.txt; \
	mkdir -p build; \
	cd build; \
	$(HOST_CMAKE_ENV) cmake .. $(HOST_CMAKE_OPTS)

define host-cmake-package
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(HOST_CMAKE); \
		$(MAKE); \
		$(MAKE) install
	$(call HOST_FOLLOWUP)
endef
