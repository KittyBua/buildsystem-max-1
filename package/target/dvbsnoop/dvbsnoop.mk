#
# dvbsnoop
#
DVBSNOOP_VER    = git
DVBSNOOP_DIR    = dvbsnoop.git
DVBSNOOP_SOURCE = dvbsnoop.git
DVBSNOOP_SITE   = https://github.com/Duckbox-Developers

$(D)/dvbsnoop: bootstrap kernel
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--enable-silent-rules \
			--prefix=/usr \
			--mandir=/.remove \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
