#
# parted
#
HOST_PARTED_VER    = 3.3
HOST_PARTED_DIR    = parted-$(PARTED_VER)
HOST_PARTED_SOURCE = parted-$(PARTED_VER).tar.xz
HOST_PARTED_SITE   = https://ftp.gnu.org/gnu/parted
HOST_PARTED_DEPS   = bootstrap

HOST_PARTED_CONF_OPTS = \
	--sbindir=/bin \
	--without-readline \
	--disable-debug \
	--disable-device-mapper

$(D)/host-parted:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(HOST_CONFIGURE); \
		$(MAKE); \
		$(MAKE) install
	$(REMOVE)
	$(TOUCH)
