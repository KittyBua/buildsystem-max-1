#
# strace
#
STRACE_VER    = 5.7
STRACE_DIR    = strace-$(STRACE_VER)
STRACE_SOURCE = strace-$(STRACE_VER).tar.xz
STRACE_SITE   = https://strace.io/files/$(STRACE_VER)

$(D)/strace: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--enable-silent-rules \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,strace-graph strace-log-merge)
	$(PKG_REMOVE)
	$(TOUCH)
