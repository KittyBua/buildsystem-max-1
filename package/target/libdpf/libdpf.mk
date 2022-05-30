################################################################################
#
# libdpf
#
##############################################################################

LIBDPF_VERSION = git
LIBDPF_DIR     = dpf-ax.git
LIBDPF_SOURCE  = dpf-ax.git
LIBDPF_SITE    = $(MAX-GIT-GITHUB)
LIBDPF_DEPENDS = bootstrap libusb-compat

define LIBDPF_INSTALL_FILES
	$(INSTALL_DATA) -D $(PKG_BUILD_DIR)/dpflib/libdpf.a $(TARGET_LIB_DIR)/libdpf.a
	$(INSTALL_DATA) -D $(PKG_BUILD_DIR)/dpflib/dpf.h $(TARGET_INCLUDE_DIR)/libdpf/libdpf.h
	$(INSTALL_DATA) -D $(PKG_BUILD_DIR)/include/spiflash.h $(TARGET_INCLUDE_DIR)/libdpf/spiflash.h
	$(INSTALL_DATA) -D $(PKG_BUILD_DIR)/include/usbuser.h $(TARGET_INCLUDE_DIR)/libdpf/usbuser.h
endef
LIBDPF_POST_INSTALL_TARGET_HOOKS += LIBDPF_INSTALL_FILES

$(D)/libdpf:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		make -C dpflib libdpf.a CC=$(TARGET_CC) PREFIX=$(TARGET_DIR)/usr
	$(call TARGET_FOLLOWUP)
