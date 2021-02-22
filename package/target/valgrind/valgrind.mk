#
# valgrind
#
VALGRIND_VER    = 3.13.0
VALGRIND_DIR    = valgrind-$(VALGRIND_VER)
VALGRIND_SOURCE = valgrind-$(VALGRIND_VER).tar.bz2
VALGRIND_SITE   = ftp://sourceware.org/pub/valgrind
VALGRIND_DEPS   = bootstrap

define VALGRIND_POST_PATCH
	$(SED) "s#armv7#arm#g" $(PKG_BUILD_DIR)/configure
endef
VALGRIND_POST_PATCH_HOOKS = VALGRIND_POST_PATCH

VALGRIND_CONF_OPTS = \
	--datadir=$(REMOVE_datarootdir) \
	--enable-only32bit

$(D)/valgrind:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/usr/lib/valgrind/,*.a *.xml)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,cg_* callgrind_* ms_print)
	$(REMOVE)
	$(TOUCH)
