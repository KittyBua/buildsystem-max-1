################################################################################
#
# host-ccache
#
################################################################################

HOST_CCACHE_VERSION = 2022-08-07
CCACHE_DIR = local

HOST_CCACHE_BIN    = /usr/bin/ccache
HOST_CCACHE_BINDIR = $(HOST_DIR)/bin

CCACHE_DIR = $(HOME)/.ccache-bs-$(TARGET_ARCH)-$(CROSSTOOL_GCC_VERSION)-kernel-$(KERNEL_VERSION)-max
export CCACHE_DIR

define HOST_CCACHE_LINK
	ln -sf $(HOST_CCACHE_BIN) $(HOST_CCACHE_BINDIR)/cc
	ln -sf $(HOST_CCACHE_BIN) $(HOST_CCACHE_BINDIR)/c++
	ln -sf $(HOST_CCACHE_BIN) $(HOST_CCACHE_BINDIR)/gcc
	ln -sf $(HOST_CCACHE_BIN) $(HOST_CCACHE_BINDIR)/g++
endef

define TARGET_CCACHE_LINK
	ln -sf $(HOST_CCACHE_BIN) $(HOST_CCACHE_BINDIR)/$(GNU_TARGET_NAME)-gcc
	ln -sf $(HOST_CCACHE_BIN) $(HOST_CCACHE_BINDIR)/$(GNU_TARGET_NAME)-g++
endef

$(D)/host-ccache: | directories
	@$(call MESSAGE,"Start-up build")
	$(call HOST_CCACHE_LINK)
	$(call TARGET_CCACHE_LINK)
	$(TOUCH)
