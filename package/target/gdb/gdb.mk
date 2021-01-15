#
# gdb
#
GDB_VER    = 8.3
GDB_DIR    = gdb-$(GDB_VER)
GDB_SOURCE = gdb-$(GDB_VER).tar.xz
GDB_SITE   = https://sourceware.org/pub/gdb/releases
GDB_DEPS   = bootstrap zlib ncurses

GDB_CONF_OPTS = \
	--enable-static \
	--disable-binutils \
	--disable-gdbserver \
	--disable-gdbtk \
	--disable-sim \
	--disable-tui \
	--disable-werror \
	--with-curses \
	--with-zlib \
	--without-mpfr \
	--without-uiout \
	--without-x

$(D)/gdb:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE) all-gdb; \
		$(MAKE) install-gdb DESTDIR=$(TARGET_DIR)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/gdb/,system-gdbinit)
	find $(TARGET_SHARE_DIR)/gdb/syscalls -type f -not -name 'arm-linux.xml' -not -name 'gdb-syscalls.dtd' -print0 | xargs -0 rm --
	$(PKG_REMOVE)
	$(TOUCH)
