#
# valgrind
#
VALGRIND_VER    = 3.13.0
VALGRIND_DIR    = valgrind-$(VALGRIND_VER)
VALGRIND_SOURCE = valgrind-$(VALGRIND_VER).tar.bz2
VALGRIND_SITE   = ftp://sourceware.org/pub/valgrind

$(D)/valgrind: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		sed -i -e "s#armv7#arm#g" configure; \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--datadir=/.remove \
			-enable-only32bit \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/usr/lib/valgrind/,*.a *.xml)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,cg_* callgrind_* ms_print)
	$(PKG_REMOVE)
	$(TOUCH)
