#
# luajson
#
LUAJSON_VERSION = 1.0
LUAJSON_SOURCE  = json.lua
LUAJSON_SITE    = https://github.com/swiboe/swiboe/raw/master/term_gui
LUAJSON_DEPENDS = bootstrap lua

$(D)/luajson:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	cp $(DL_DIR)/json.lua $(TARGET_SHARE_DIR)/lua/$(LUA_ABIVERSION)/json.lua
	$(TOUCH)
