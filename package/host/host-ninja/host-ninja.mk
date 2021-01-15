#
# host-ninja
#
HOST_NINJA_VER    = 1.10.0
HOST_NINJA_DIR    = ninja-$(HOST_NINJA_VER)
HOST_NINJA_SOURCE = ninja-$(HOST_NINJA_VER).tar.gz
HOST_NINJA_SITE   = $(call github,ninja-build,ninja,v$(HOST_NINJA_VER))
HOST_NINJA_DEPS   = bootstrap

$(D)/host-ninja:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		cmake . \
			-DCMAKE_INSTALL_PREFIX="" \
		; \
		$(MAKE)
		$(INSTALL_EXEC) -D $(PKG_BUILD_DIR)/ninja $(HOST_DIR)/bin/ninja
	$(PKG_REMOVE)
	$(TOUCH)
