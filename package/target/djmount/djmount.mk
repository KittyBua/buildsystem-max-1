#
# djmount
#
DJMOUNT_VER    = 0.71
DJMOUNT_DIR    = djmount-$(DJMOUNT_VER)
DJMOUNT_SOURCE = djmount-$(DJMOUNT_VER).tar.gz
DJMOUNT_SITE   = https://sourceforge.net/projects/djmount/files/djmount/$(DJMOUNT_VER)
DJMOUNT_DEPS   = bootstrap libupnp libfuse

DJMOUNT_AUTORECONF = YES

define DJMOUNT_POST_PATCH
	touch $(PKG_BUILD_DIR)/libupnp/config.aux/config.rpath
endef
DJMOUNT_POST_PATCH_HOOKS += DJMOUNT_POST_PATCH

DJMOUNT_CONF_OPTS = \
	--with-external-libupnp \
	--with-fuse-prefix=$(TARGET_DIR)/usr \
	--with-libupnp-prefix=$(TARGET_DIR)/usr \
	--disable-debug

$(D)/djmount:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
