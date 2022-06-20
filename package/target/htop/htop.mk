################################################################################
#
# htop
#
################################################################################

HTOP_VERSION = 3.2.1
HTOP_DIR     = htop-$(HTOP_VERSION)
HTOP_SOURCE  = htop-$(HTOP_VERSION).tar.gz
HTOP_SITE    = $(call github,htop-dev,htop,$(HTOP_VERSION))
HTOP_DEPENDS = bootstrap ncurses libcap libnl

HTOP_AUTORECONF = YES

HTOP_CONF_ENV = \
	ac_cv_file__proc_stat=yes \
	ac_cv_file__proc_meminfo=yes

HTOP_CONF_OPTS = \
	--enable-affinity \
	--enable-capabilities \
	--enable-unicode \
	--disable-hwloc

define HTOP_CLEANUP_TARGET
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,applications icons pixmaps)
endef
HTOP_CLEANUP_TARGET_HOOKS += HTOP_CLEANUP_TARGET

$(D)/htop:
	$(call make-package)
