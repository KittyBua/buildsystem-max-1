################################################################################
#
# host-ccache
#
################################################################################

HOST_CCACHE_VERSION = 2021-03-29
HOST_CCACHE_DIR = local

HOST_CCACHE_DEPENDS = directories

HOST_CCACHE_BIN    = /usr/bin/ccache
HOST_CCACHE_BINDIR = $(HOST_DIR)/bin

CCACHE_DIR = $(HOME)/.ccache-bs-$(TARGET_ARCH)-$(CROSSTOOL_GCC_VERSION)-kernel-$(KERNEL_VERSION)-max
export CCACHE_DIR

define HOST_CCACHE_LINK
	ln -sf $(HOST_CCACHE_BIN) $(HOST_CCACHE_BINDIR)/cc; \
	ln -sf $(HOST_CCACHE_BIN) $(HOST_CCACHE_BINDIR)/c++; \
	ln -sf $(HOST_CCACHE_BIN) $(HOST_CCACHE_BINDIR)/gcc; \
	ln -sf $(HOST_CCACHE_BIN) $(HOST_CCACHE_BINDIR)/g++
endef

define TARGET_CCACHE_LINK
	ln -sf $(HOST_CCACHE_BIN) $(HOST_CCACHE_BINDIR)/$(GNU_TARGET_NAME)-gcc; \
	ln -sf $(HOST_CCACHE_BIN) $(HOST_CCACHE_BINDIR)/$(GNU_TARGET_NAME)-g++
endef

$(D)/host-ccache:
	$(call STARTUP)
	$(HOST_CCACHE_LINK)
	$(TARGET_CCACHE_LINK)
	$(TOUCH)
