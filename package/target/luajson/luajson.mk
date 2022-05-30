################################################################################
#
# luajson
#
################################################################################

LUAJSON_VERSION = 1.0
LUAJSON_SOURCE  = json.lua
LUAJSON_SITE    = https://github.com/swiboe/swiboe/raw/master/term_gui
LUAJSON_DEPENDS = bootstrap lua

define LUAJSON_INSTALL_FILES
	$(INSTALL_DATA) -D $(DL_DIR)/$(LUAJSON_SOURCE) $(TARGET_SHARE_DIR)/lua/$(LUA_ABIVERSION)/json.lua
endef
LUAJSON_POST_INSTALL_TARGET_HOOKS += LUAJSON_INSTALL_FILES

$(D)/luajson:
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call TARGET_FOLLOWUP)
