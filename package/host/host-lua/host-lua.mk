################################################################################
#
# host-lua
#
################################################################################

HOST_LUA_VERSION = $(LUA_VERSION)
HOST_LUA_ABIVERSION = $(basename $(HOST_LUA_VERSION))
HOST_LUA_DIR = lua-$(HOST_LUA_VERSION)
HOST_LUA_SOURCE = lua-$(HOST_LUA_VERSION).tar.gz
HOST_LUA_SITE = https://www.lua.org/ftp

HOST_LUA_DEPENDS = bootstrap

HOST_LUA_BINARY = $(HOST_DIR)/bin/lua

HOST_LUA_MAKE_ARGS = \
	linux

HOST_LUA_MAKE_INSTALL_OPTS = \
	INSTALL_TOP=$(HOST_DIR)

$(D)/host-lua:
	$(call host-generic-package)
