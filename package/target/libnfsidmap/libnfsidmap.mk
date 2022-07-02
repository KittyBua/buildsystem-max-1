################################################################################
#
# libnfsidmap
#
################################################################################

LIBNFSIDMAP_VERSION = 0.25
LIBNFSIDMAP_DIR     = libnfsidmap-$(LIBNFSIDMAP_VERSION)
LIBNFSIDMAP_SOURCE  = libnfsidmap-$(LIBNFSIDMAP_VERSION).tar.gz
LIBNFSIDMAP_SITE    = http://www.citi.umich.edu/projects/nfsv4/linux/libnfsidmap
LIBNFSIDMAP_DEPENDS = bootstrap

LIBNFSIDMAP_CONF_OPTS = \
	ac_cv_func_malloc_0_nonnull=yes

$(D)/libnfsidmap:
	$(call autotools-package)
