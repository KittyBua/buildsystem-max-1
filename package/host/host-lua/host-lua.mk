#
# host-lua
#
HOST_LUA_VER    = 5.2.4
HOST_LUA_ABIVER = $(basename $(HOST_LUA_VER))
HOST_LUA_DIR    = lua-$(HOST_LUA_VER)
HOST_LUA_SOURCE = lua-$(HOST_LUA_VER).tar.gz
HOST_LUA_SITE   = https://www.lua.org/ftp

HOST_LUA_PATCH  = \
	0001-fix-lua-root.patch \
	0002-remove-readline.patch

HOST_LUA_BINARY = $(HOST_DIR)/bin/lua

$(D)/host-lua: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(MAKE) linux; \
		$(MAKE) install INSTALL_TOP=$(HOST_DIR)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
