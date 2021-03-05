#
# dbus
#
DBUS_VER    = 1.12.6
DBUS_DIR    = dbus-$(DBUS_VER)
DBUS_SOURCE = dbus-$(DBUS_VER).tar.gz
DBUS_SITE   = https://dbus.freedesktop.org/releases/dbus
DBUS_DEPS   = bootstrap expat

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

$(D)/dbus:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,dbus-cleanup-sockets dbus-daemon dbus-launch dbus-monitor)
	$(TOUCH)
