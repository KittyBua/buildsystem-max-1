#
# dbus
#
DBUS_VER    = 1.12.6
DBUS_DIR    = dbus-$(DBUS_VER)
DBUS_SOURCE = dbus-$(DBUS_VER).tar.gz
DBUS_SITE   = https://dbus.freedesktop.org/releases/dbus

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
DBUS_DEPS += systemd
else
DBUS_CONF_OPTS += \
	--disable-systemd \
	--without-systemdsystemunitdir
endif

$(D)/dbus: bootstrap expat
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,dbus-cleanup-sockets dbus-daemon dbus-launch dbus-monitor)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
