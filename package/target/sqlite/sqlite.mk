################################################################################
#
# sqlite
#
################################################################################

SQLITE_VERSION = 3390000
SQLITE_DIR = sqlite-autoconf-$(SQLITE_VERSION)
SQLITE_SOURCE = sqlite-autoconf-$(SQLITE_VERSION).tar.gz
SQLITE_SITE = http://www.sqlite.org/2022

SQLITE_CONF_OPTS = \
	--enable-shared \
	--enable-threadsafe \
	--disable-static-shell

define SQLITE_TARGET_CLEANUP
	rm -f $(addprefix $(TARGET_BIN_DIR)/,sqlite3)
endef
SQLITE_TARGET_CLEANUP_HOOKS += SQLITE_TARGET_CLEANUP

$(D)/sqlite: | bootstrap
	$(call autotools-package)
