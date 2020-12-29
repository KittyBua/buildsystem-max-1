#
# luaexpat
#
LUAEXPAT_VER    = 1.3.3
LUAEXPAT_DIR    = luaexpat-$(LUAEXPAT_VER)
LUAEXPAT_SOURCE = luaexpat-$(LUAEXPAT_VER).tar.gz
LUAEXPAT_SITE   = $(call github,tomasguisasola,luaexpat,v$(LUAEXPAT_VER))

LUAEXPAT_PATCH = \
	0001-restore-getcurrentbytecount.patch

$(D)/luaexpat: bootstrap lua expat
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		$(SED) 's|^EXPAT_INC=.*|EXPAT_INC= $(TARGET_INCLUDE_DIR)|' makefile; \
		$(SED) 's|^CFLAGS =.*|& -L$(TARGET_LIB_DIR)|' makefile; \
		$(SED) 's|^CC =.*|CC = $(TARGET_CC)|' makefile; \
		$(BUILD_ENV) \
		$(MAKE) \
			PREFIX=$(TARGET_DIR)/usr \
			LUA_SYS_VER=$(LUA_ABIVER) \
			; \
		$(MAKE) install \
			PREFIX=$(TARGET_DIR)/usr \
			LUA_SYS_VER=$(LUA_ABIVER)
	$(PKG_REMOVE)
	$(TOUCH)
