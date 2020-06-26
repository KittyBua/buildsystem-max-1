#
# host-ninja
#
HOST_NINJA_VER    = 1.10.0
HOST_NINJA_DIR    = ninja-$(HOST_NINJA_VER)
HOST_NINJA_SOURCE = ninja-$(HOST_NINJA_VER).tar.gz
HOST_NINJA_GIT    = v$(HOST_NINJA_VER).tar.gz -O $(DL_DIR)/$(HOST_NINJA_SOURCE)
HOST_NINJA_SITE   = https://github.com/ninja-build/ninja/archive

HOST_NINJA_PATCH = \
	0001-set-minimum-cmake-version-to-3.10.patch \
	0002-remove-fdiagnostics-color-from-make-command.patch \
	0003-CMake-fix-object-library-usage.patch

$(D)/host-ninja: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(HOST_NINJA_GIT))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		cmake . \
			-DCMAKE_INSTALL_PREFIX="" \
		; \
		$(MAKE)
		$(INSTALL_EXEC) -D $(PKG_BUILD_DIR)/ninja $(HOST_DIR)/bin/ninja
	$(PKG_REMOVE)
	$(TOUCH)
