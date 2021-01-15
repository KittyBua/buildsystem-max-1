#
# luajson
#
LUAJSON_VER    = 1.0
LUAJSON_SOURCE = json.lua
LUAJSON_SITE   = https://github.com/swiboe/swiboe/raw/master/term_gui
LUAJSON_DEPS   = bootstrap lua

$(D)/luajson:
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	cp $(DL_DIR)/json.lua $(TARGET_SHARE_DIR)/lua/$(LUA_ABIVER)/json.lua
	$(TOUCH)
