#
# luajson
#
LUAJSON_SOURCE = json.lua
LUAJSON_URL    = https://github.com/swiboe/swiboe/raw/master/term_gui

$(D)/luajson: bootstrap lua
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	cp $(DL_DIR)/json.lua $(TARGET_SHARE_DIR)/lua/$(LUA_ABIVER)/json.lua
	$(TOUCH)
