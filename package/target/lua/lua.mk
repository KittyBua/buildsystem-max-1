################################################################################
#
# lua
#
################################################################################

LUA_VERSION = 5.2.4
LUA_ABIVERSION = $(basename $(LUA_VERSION))
LUA_DIR = lua-$(LUA_VERSION)
LUA_SOURCE = lua-$(LUA_VERSION).tar.gz
LUA_SITE = https://www.lua.org/ftp

LUA_DEPENDS = bootstrap host-lua ncurses

LUA_MAKE_ARGS = \
	linux

LUA_MAKE_OPTS = \
	BUILDMODE=dynamic \
	PKG_VERSION=$(LUA_VERSION) \
	CC=$(TARGET_CC) \
	CPPFLAGS="$(TARGET_CPPFLAGS) -fPIC" \
	LDFLAGS="-L$(TARGET_LIB_DIR)" \
	AR="$(TARGET_AR) rcu"

LUA_MAKE_INSTALL_OPTS = \
	INSTALL_TOP=$(TARGET_DIR)/usr \
	INSTALL_MAN=$(TARGET_DIR)$(REMOVE_mandir)

define LUA_TARGET_CLEANUP
	rm -f $(addprefix $(TARGET_BIN_DIR)/,luac)
endef
LUA_TARGET_CLEANUP_HOOKS += LUA_TARGET_CLEANUP

$(D)/lua:
	$(call make-package)
