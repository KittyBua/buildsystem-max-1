#
# luaexpat
#
LUAEXPAT_VER    = 1.3.3
LUAEXPAT_DIR    = luaexpat-$(LUAEXPAT_VER)
LUAEXPAT_SOURCE = luaexpat-$(LUAEXPAT_VER).tar.gz
LUAEXPAT_SITE   = $(call github,tomasguisasola,luaexpat,v$(LUAEXPAT_VER))
LUAEXPAT_DEPS   = bootstrap lua expat

define LUAEXPAT_POST_PATCH
	$(SED) 's|^EXPAT_INC=.*|EXPAT_INC= $(TARGET_INCLUDE_DIR)|' $(PKG_BUILD_DIR)/makefile
	$(SED) 's|^CFLAGS =.*|& -L$(TARGET_LIB_DIR)|' $(PKG_BUILD_DIR)/makefile
	$(SED) 's|^CC =.*|CC = $(TARGET_CC)|' $(PKG_BUILD_DIR)/makefile
endef
LUAEXPAT_POST_PATCH_HOOKS = LUAEXPAT_POST_PATCH

$(D)/luaexpat:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(MAKE) \
			PREFIX=$(TARGET_DIR)/usr \
			LUA_SYS_VER=$(LUA_ABIVER) \
			; \
		$(MAKE) install \
			PREFIX=$(TARGET_DIR)/usr \
			LUA_SYS_VER=$(LUA_ABIVER)
	$(REMOVE)
	$(TOUCH)
