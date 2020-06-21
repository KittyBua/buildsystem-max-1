#
# djmount
#
DJMOUNT_VER    = 0.71
DJMOUNT_DIR    = djmount-$(DJMOUNT_VER)
DJMOUNT_SOURCE = djmount-$(DJMOUNT_VER).tar.gz
DJMOUNT_SITE   = https://sourceforge.net/projects/djmount/files/djmount/$(DJMOUNT_VER)

DJMOUNT_PATCH  = \
	0001-fix-newer-gcc.patch \
	0002-fix-hang-with-asset-upnp.patch \
	0003-fix-incorrect-range-when-retrieving-content-via-HTTP.patch \
	0004-fix-new-autotools.patch \
	0005-fixed-crash-when-using-UTF-8-charset.patch \
	0006-fixed-crash.patch \
	0007-support-fstab-mounting.patch \
	0008-support-seeking-in-large-2gb-files.patch

$(D)/djmount: bootstrap libfuse
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		touch libupnp/config.aux/config.rpath; \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) -C \
			--prefix=/usr \
			--disable-debug \
			; \
		make; \
		make install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
