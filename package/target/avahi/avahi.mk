#
# avahi
#
AVAHI_VER    = 0.7
AVAHI_DIR    = avahi-$(AVAHI_VER)
AVAHI_SOURCE = avahi-$(AVAHI_VER).tar.gz
AVAHI_SITE   = https://github.com/lathiat/avahi/releases/download/v$(AVAHI_VER)
AVAHI_DEPS   = bootstrap expat libdaemon dbus

AVAHI_CONF_OPTS = \
	--localedir=$(REMOVE_localedir) \
	--with-distro=none \
	--with-avahi-user=nobody \
	--with-avahi-group=nogroup \
	--with-autoipd-user=nobody \
	--with-autoipd-group=nogroup \
	--with-xml=expat \
	--enable-libdaemon \
	--disable-nls \
	--disable-glib \
	--disable-gobject \
	--disable-qt3 \
	--disable-qt4 \
	--disable-gtk \
	--disable-gtk3 \
	--disable-dbm \
	--disable-gdbm \
	--disable-python \
	--disable-python-dbus \
	--disable-mono \
	--disable-monodoc \
	--disable-autoipd \
	--disable-doxygen-doc \
	--disable-doxygen-dot \
	--disable-doxygen-man \
	--disable-doxygen-rtf \
	--disable-doxygen-xml \
	--disable-doxygen-chm \
	--disable-doxygen-chi \
	--disable-doxygen-html \
	--disable-doxygen-ps \
	--disable-doxygen-pdf \
	--disable-core-docs \
	--disable-manpages \
	--disable-xmltoman \
	--disable-tests

$(D)/avahi:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	cp $(PKG_BUILD_DIR)/avahi-daemon/avahi-daemon $(TARGET_DIR)/etc/init.d
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
