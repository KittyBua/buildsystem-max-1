#
# luasocket
#
LUASOCKET_VERSION = git
LUASOCKET_DIR     = luasocket.git
LUASOCKET_SOURCE  = luasocket.git
LUASOCKET_SITE    = git://github.com/diegonehab
LUASOCKET_DEPENDS = bootstrap lua

define LUASOCKET_POST_PATCH
	$(SED) "s@LD_linux=gcc@LD_LINUX=$(TARGET_CC)@; \
		s@CC_linux=gcc@CC_LINUX=$(TARGET_CC) -L$(TARGET_LIB_DIR)@; \
		s@DESTDIR?=@DESTDIR?=$(TARGET_DIR)/usr@" \
		$(PKG_BUILD_DIR)/src/makefile
endef
LUASOCKET_POST_PATCH_HOOKS = LUASOCKET_POST_PATCH

luasocket:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MAKE) CC=$(GNU_TARGET_NAME)-gcc LD=$(GNU_TARGET_NAME)-gcc LUAV=$(LUA_ABIVERSION) PLAT=linux COMPAT=COMPAT LUAINC_linux=$(TARGET_INCLUDE_DIR) LUAPREFIX_linux=; \
		$(MAKE) install LUAPREFIX_linux= LUAV=$(LUA_ABIVERSION)
	$(REMOVE)
	$(TOUCH)
