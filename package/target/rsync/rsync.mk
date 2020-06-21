#
# rsync
#
RSYNC_VER    = 3.1.3
RSYNC_DIR    = rsync-$(RSYNC_VER)
RSYNC_SOURCE = rsync-$(RSYNC_VER).tar.gz
RSYNC_SITE   = https://ftp.samba.org/pub/rsync

RSYNC_PATCH  = \
	001-rsync-sysmacros.patch

$(D)/rsync: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--sysconfdir=/etc \
			--disable-debug \
			--disable-locale \
			; \
		$(MAKE) all; \
		$(MAKE) install-all DESTDIR=$(TARGET_DIR)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
