#
# luasoap
#
LUASOAP_VER    = 3.0
LUASOAP_DIR    = luasoap-$(LUASOAP_VER)
LUASOAP_SOURCE = luasoap-$(LUASOAP_VER).tar.gz
LUASOAP_SITE   = https://github.com/downloads/tomasguisasola/luasoap
LUASOAP_DEPS   = bootstrap lua luasocket luaexpat

$(D)/luasoap:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(MAKE) install LUA_DIR=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVER)
	$(REMOVE)
	$(TOUCH)
