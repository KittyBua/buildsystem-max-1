#
# host-lua
#
HOST_LUA_VER    = 5.2.4
HOST_LUA_ABIVER = $(basename $(HOST_LUA_VER))
HOST_LUA_DIR    = lua-$(HOST_LUA_VER)
HOST_LUA_SOURCE = lua-$(HOST_LUA_VER).tar.gz
HOST_LUA_SITE   = https://www.lua.org/ftp
HOST_LUA_DEPS   = bootstrap

HOST_LUA_BINARY = $(HOST_DIR)/bin/lua

$(D)/host-lua:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(MAKE) linux; \
		$(MAKE) install INSTALL_TOP=$(HOST_DIR)
	$(REMOVE)
	$(TOUCH)
