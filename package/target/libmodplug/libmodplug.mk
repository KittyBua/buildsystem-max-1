################################################################################
#
# libmodplug
#
################################################################################

LIBMODPLUG_VERSION = 0.8.8.4
LIBMODPLUG_DIR = libmodplug-$(LIBMODPLUG_VERSION)
LIBMODPLUG_SOURCE = libmodplug-$(LIBMODPLUG_VERSION).tar.gz
LIBMODPLUG_SITE = https://sourceforge.net/projects/modplug-xmms/files/libmodplug/$(LIBMODPLUG_VERSION)

$(D)/libmodplug: | bootstrap
	$(call autotools-package)
