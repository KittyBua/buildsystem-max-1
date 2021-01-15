#
# parted
#
HOST_PARTED_VER    = 3.3
HOST_PARTED_DIR    = parted-$(PARTED_VER)
HOST_PARTED_SOURCE = parted-$(PARTED_VER).tar.xz
HOST_PARTED_SITE   = https://ftp.gnu.org/gnu/parted
HOST_PARTED_DEPS   = bootstrap

$(D)/host-parted:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		./configure \
			--prefix=$(HOST_DIR) \
			--sbindir=/bin \
			--without-readline \
			--disable-debug \
			--disable-device-mapper \
			; \
		$(MAKE); \
		$(MAKE) install
	$(PKG_REMOVE)
	$(TOUCH)
