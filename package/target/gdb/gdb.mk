#
# gdb
#
GDB_VER    = 8.3
GDB_DIR    = gdb-$(GDB_VER)
GDB_SOURCE = gdb-$(GDB_VER).tar.xz
GDB_SITE   = https://sourceware.org/pub/gdb/releases

$(D)/gdb: bootstrap zlib ncurses
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--infodir=/.remove \
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
			--without-x \
			--enable-static \
			; \
		$(MAKE) all-gdb; \
		$(MAKE) install-gdb DESTDIR=$(TARGET_DIR)
	rm -rf $(addprefix $(TARGET_DIR)/usr/share/,system-gdbinit)
	find $(TARGET_SHARE_DIR)/gdb/syscalls -type f -not -name 'arm-linux.xml' -not -name 'gdb-syscalls.dtd' -print0 | xargs -0 rm --
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
