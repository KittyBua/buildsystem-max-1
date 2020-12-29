#
# valgrind
#
VALGRIND_VER    = 3.13.0
VALGRIND_DIR    = valgrind-$(VALGRIND_VER)
VALGRIND_SOURCE = valgrind-$(VALGRIND_VER).tar.bz2
VALGRIND_SITE   = ftp://sourceware.org/pub/valgrind

VALGRIND_CONF_OPTS = \
	--datadir=$(REMOVE_datarootdir) \
	--enable-only32bit

$(D)/valgrind: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(SED) "s#armv7#arm#g" configure; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/usr/lib/valgrind/,*.a *.xml)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,cg_* callgrind_* ms_print)
	$(PKG_REMOVE)
	$(TOUCH)
