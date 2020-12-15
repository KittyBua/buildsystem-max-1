#
# ntp
#
NTP_VER    = 4.2.8p15
NTP_DIR    = ntp-$(NTP_VER)
NTP_SOURCE = ntp-$(NTP_VER).tar.gz
NTP_SITE   = https://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-$(basename $(NTP_VER))

NTP_PATCH = \
	0001-mkver_in.patch

NTP_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--disable-debugging \
	--with-shared \
	--with-crypto \
	--with-yielding-select=yes \
	--without-ntpsnmpd

$(D)/ntp: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
