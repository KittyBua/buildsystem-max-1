################################################################################
#
# sqlite
#
################################################################################

SQLITE_VERSION = 3350500
SQLITE_DIR     = sqlite-autoconf-$(SQLITE_VERSION)
SQLITE_SOURCE  = sqlite-autoconf-$(SQLITE_VERSION).tar.gz
SQLITE_SITE    = http://www.sqlite.org/2021
SQLITE_DEPENDS = bootstrap

SQLITE_CONF_OPTS = \
	--enable-shared \
	--enable-threadsafe \
	--disable-static-shell

define SQLITE_CLEANUP_TARGET
	rm -f $(addprefix $(TARGET_BIN_DIR)/,sqlite3)
endef
SQLITE_CLEANUP_TARGET_HOOKS += SQLITE_CLEANUP_TARGET

$(D)/sqlite:
	$(call make-package)
