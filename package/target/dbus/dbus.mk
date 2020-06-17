#
# dbus
#
DBUS_VER    = 1.12.6
DBUS_DIR    = dbus-$(DBUS_VER)
DBUS_SOURCE = dbus-$(DBUS_VER).tar.gz
DBUS_SITE   = https://dbus.freedesktop.org/releases/dbus

$(D)/dbus: bootstrap expat
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(CONFIGURE) \
		CFLAGS="$(TARGET_CFLAGS) -Wno-cast-align" \
			--without-x \
			--prefix=/usr \
			--docdir=/.remove \
			--sysconfdir=/etc \
			--localstatedir=/var \
			--with-console-auth-dir=/var/run/console/ \
			--without-systemdsystemunitdir \
			--disable-systemd \
			--disable-static \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,dbus-cleanup-sockets dbus-daemon dbus-launch dbus-monitor)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
