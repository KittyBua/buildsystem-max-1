################################################################################
#
# libdvdcss
#
################################################################################

LIBDVDCSS_VERSION = 1.4.2
LIBDVDCSS_DIR     = libdvdcss-$(LIBDVDCSS_VERSION)
LIBDVDCSS_SOURCE  = libdvdcss-$(LIBDVDCSS_VERSION).tar.bz2
LIBDVDCSS_SITE    = https://download.videolan.org/pub/libdvdcss/$(LIBDVDCSS_VERSION)
LIBDVDCSS_DEPENDS = bootstrap

LIBDVDCSS_CONF_OPTS = \
	--docdir=$(REMOVE_docdir)

$(D)/libdvdcss:
	$(call autotools-package)
