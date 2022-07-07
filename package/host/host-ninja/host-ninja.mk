################################################################################
#
# host-ninja
#
################################################################################

HOST_NINJA_VERSION = 1.10.2
HOST_NINJA_DIR = ninja-$(HOST_NINJA_VERSION)
HOST_NINJA_SOURCE = ninja-$(HOST_NINJA_VERSION).tar.gz
HOST_NINJA_SITE = $(call github,ninja-build,ninja,v$(HOST_NINJA_VERSION))

HOST_NINJA_DEPENDS = bootstrap

HOST_NINJA_BINARY = $(HOST_DIR)/bin/ninja

$(D)/host-ninja:
	$(call host-cmake-package)
