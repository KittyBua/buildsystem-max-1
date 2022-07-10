################################################################################
#
# dbus
#
################################################################################

DBUS_VERSION = 1.12.6
DBUS_DIR = dbus-$(DBUS_VERSION)
DBUS_SOURCE = dbus-$(DBUS_VERSION).tar.gz
DBUS_SITE = https://dbus.freedesktop.org/releases/dbus

DBUS_DEPENDS = expat

DBUS_CONF_OPTS = \
	CFLAGS="$(TARGET_CFLAGS) -Wno-cast-align" \
	--docdir=$(REMOVE_docdir) \
	--disable-static \
	--disable-tests \
	--disable-asserts \
	--disable-xml-docs \
	--disable-doxygen-docs \
	--without-x

ifeq ($(BS_INIT_SYSV),1)
DBUS_CONF_OPTS += \
	--disable-systemd \
	--without-systemdsystemunitdir
else
DBUS_CONF_OPTS += \
	--enable-systemd \
	--with-systemdsystemunitdir=/usr/lib/systemd/system
DBUS_DEPENDS += systemd
endif

define DBUS_TARGET_CLEANUP
	rm -f $(addprefix $(TARGET_BIN_DIR)/,dbus-cleanup-sockets dbus-daemon dbus-launch dbus-monitor)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,xml)
endef
DBUS_TARGET_CLEANUP_HOOKS += DBUS_TARGET_CLEANUP

$(D)/dbus: | bootstrap
	$(call autotools-package)
