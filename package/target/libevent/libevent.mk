#
# libevent
#
LIBEVENT_VER    = 2.1.11-stable
LIBEVENT_DIR    = libevent-$(LIBEVENT_VER)
LIBEVENT_SOURCE = libevent-$(LIBEVENT_VER).tar.gz
LIBEVENT_URL    = https://github.com/libevent/libevent/releases/download/release-$(LIBEVENT_VER)

$(D)/libevent: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,event_rpcgen.py)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
