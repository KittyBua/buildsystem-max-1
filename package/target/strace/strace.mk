#
# strace
#
STRACE_VERSION = 5.7
STRACE_DIR     = strace-$(STRACE_VERSION)
STRACE_SOURCE  = strace-$(STRACE_VERSION).tar.xz
STRACE_SITE    = https://strace.io/files/$(STRACE_VERSION)
STRACE_DEPENDS = bootstrap

STRACE_CONF_OPTS = \
	--enable-silent-rules

$(D)/strace:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,strace-graph strace-log-merge)
	$(TOUCH)
