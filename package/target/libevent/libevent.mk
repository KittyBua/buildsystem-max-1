#
# libevent
#
LIBEVENT_VER    = 2.1.11-stable
LIBEVENT_DIR    = libevent-$(LIBEVENT_VER)
LIBEVENT_SOURCE = libevent-$(LIBEVENT_VER).tar.gz
LIBEVENT_SITE   = https://github.com/libevent/libevent/releases/download/release-$(LIBEVENT_VER)
LIBEVENT_DEPS   = bootstrap

$(D)/libevent:
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
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,event_rpcgen.py)
	$(TOUCH)
