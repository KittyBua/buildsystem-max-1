################################################################################
#
# libmnl
#
################################################################################

LIBMNL_VERSION = 1.0.4
LIBMNL_DIR = libmnl-$(LIBMNL_VERSION)
LIBMNL_SOURCE = libmnl-$(LIBMNL_VERSION).tar.bz2
LIBMNL_SITE = http://netfilter.org/projects/libmnl/files

$(D)/libmnl: | bootstrap
	$(call autotools-package)
