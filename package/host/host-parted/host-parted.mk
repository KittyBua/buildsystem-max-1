################################################################################
#
# parted
#
################################################################################

HOST_PARTED_CONF_OPTS = \
	--sbindir=$(HOST_DIR)/bin \
	--without-readline \
	--disable-debug \
	--disable-device-mapper

$(D)/host-parted: | bootstrap
	$(call host-autotools-package)
