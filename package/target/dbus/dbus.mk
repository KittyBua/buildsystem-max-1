################################################################################
#
# dbus
#
################################################################################

DBUS_VERSION = 1.12.6
DBUS_DIR     = dbus-$(DBUS_VERSION)
DBUS_SOURCE  = dbus-$(DBUS_VERSION).tar.gz
DBUS_SITE    = https://dbus.freedesktop.org/releases/dbus
DBUS_DEPENDS = bootstrap expat

DBUS_CONF_OPTS = \
	CFLAGS="$(TARGET_CFLAGS) -Wno-cast-align" \
	--docdir=$(REMOVE_docdir) \
	--disable-static \
	--disable-tests \
	--disable-asserts \
	--disable-xml-docs \
	--disable-doxygen-docs \
	--without-x

ifeq ($(BS_INIT_SYSTEMD),y)
DBUS_CONF_OPTS += \
	--enable-systemd \
	--with-systemdsystemunitdir=/usr/lib/systemd/system
DBUS_DEPENDS += systemd
else
DBUS_CONF_OPTS += \
	--disable-systemd \
	--without-systemdsystemunitdir
endif

define DBUS_CLEANUP_TARGET
	rm -f $(addprefix $(TARGET_BIN_DIR)/,dbus-cleanup-sockets dbus-daemon dbus-launch dbus-monitor)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,xml)
endef
DBUS_CLEANUP_TARGET_HOOKS += DBUS_CLEANUP_TARGET

$(D)/dbus:
	$(call autotools-package)
