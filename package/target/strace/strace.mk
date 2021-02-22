#
# strace
#
STRACE_VER    = 5.7
STRACE_DIR    = strace-$(STRACE_VER)
STRACE_SOURCE = strace-$(STRACE_VER).tar.xz
STRACE_SITE   = https://strace.io/files/$(STRACE_VER)
STRACE_DEPS   = bootstrap

STRACE_CONF_OPTS = \
	--enable-silent-rules

$(D)/strace:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,strace-graph strace-log-merge)
	$(REMOVE)
	$(TOUCH)
