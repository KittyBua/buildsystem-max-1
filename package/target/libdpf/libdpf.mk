#
# libdpf
#
LIBDPF_VER    = git
LIBDPF_DIR    = dpf-ax.git
LIBDPF_SOURCE = dpf-ax.git
LIBDPF_SITE   = $(MAX-GIT-GITHUB)

LIBDPF_PATCH  = \
	0001-crossbuild.patch

$(D)/libdpf: bootstrap libusb-compat
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_CPDIR)
	$(PKG_CHDIR)/dpflib; \
		$(call apply_patches, $(PKG_PATCH)); \
		make libdpf.a CC=$(TARGET_CC) PREFIX=$(TARGET_DIR)/usr; \
		mkdir -p $(TARGET_INCLUDE_DIR)/libdpf; \
		cp dpf.h $(TARGET_INCLUDE_DIR)/libdpf/libdpf.h; \
		cp ../include/spiflash.h $(TARGET_INCLUDE_DIR)/libdpf/; \
		cp ../include/usbuser.h $(TARGET_INCLUDE_DIR)/libdpf/; \
		cp libdpf.a $(TARGET_LIB_DIR)/
	$(PKG_REMOVE)
	$(TOUCH)
