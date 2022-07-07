################################################################################
#
# gdb
#
################################################################################

GDB_VERSION = 8.3
GDB_DIR = gdb-$(GDB_VERSION)
GDB_SOURCE = gdb-$(GDB_VERSION).tar.xz
GDB_SITE = https://sourceware.org/pub/gdb/releases

GDB_DEPENDS = bootstrap zlib ncurses

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

define GDB_TARGET_CLEANUP
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/gdb/,system-gdbinit)
	find $(TARGET_SHARE_DIR)/gdb/syscalls -type f -not -name 'arm-linux.xml' -not -name 'gdb-syscalls.dtd' -print0 | xargs -0 rm --
endef
GDB_TARGET_CLEANUP_HOOKS += GDB_TARGET_CLEANUP

$(D)/gdb:
	$(call PREPARE)
	$(call TARGET_CONFIGURE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) all-gdb; \
		$(MAKE) install-gdb DESTDIR=$(TARGET_DIR)
	$(call TARGET_FOLLOWUP)
