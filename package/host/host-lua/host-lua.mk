################################################################################
#
# host-lua
#
################################################################################

HOST_LUA_VERSION    = 5.2.4
HOST_LUA_ABIVERSION = $(basename $(HOST_LUA_VERSION))
HOST_LUA_DIR        = lua-$(HOST_LUA_VERSION)
HOST_LUA_SOURCE     = lua-$(HOST_LUA_VERSION).tar.gz
HOST_LUA_SITE       = https://www.lua.org/ftp
HOST_LUA_DEPENDS    = bootstrap

HOST_LUA_BINARY = $(HOST_DIR)/bin/lua

$(D)/host-lua:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) linux; \
		$(MAKE) install INSTALL_TOP=$(HOST_DIR)
	$(call TARGET_FOLLOWUP)
