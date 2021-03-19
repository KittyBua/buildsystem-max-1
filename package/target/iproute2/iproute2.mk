#
# iproute2
#
IPROUTE2_VER    = 5.7.0
IPROUTE2_DIR    = iproute2-$(IPROUTE2_VER)
IPROUTE2_SOURCE = iproute2-$(IPROUTE2_VER).tar.xz
IPROUTE2_SITE   = https://kernel.org/pub/linux/utils/net/iproute2
IPROUTE2_DEPS   = bootstrap libmnl

$(D)/iproute2:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR) MANDIR=$(TARGET_DIR)$(REMOVE_mandir)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
