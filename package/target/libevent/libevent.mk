#
# libevent
#
LIBEVENT_VER    = 2.1.11-stable
LIBEVENT_DIR    = libevent-$(LIBEVENT_VER)
LIBEVENT_SOURCE = libevent-$(LIBEVENT_VER).tar.gz
LIBEVENT_SITE   = https://github.com/libevent/libevent/releases/download/release-$(LIBEVENT_VER)

$(D)/libevent: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,event_rpcgen.py)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
