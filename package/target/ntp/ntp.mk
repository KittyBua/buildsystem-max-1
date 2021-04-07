#
# ntp
#
NTP_VERSION = 4.2.8p15
NTP_DIR     = ntp-$(NTP_VERSION)
NTP_SOURCE  = ntp-$(NTP_VERSION).tar.gz
NTP_SITE    = https://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-$(basename $(NTP_VERSION))
NTP_DEPENDS = bootstrap

NTP_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--disable-debugging \
	--with-shared \
	--with-crypto \
	--with-yielding-select=yes \
	--without-ntpsnmpd

$(D)/ntp:
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
	$(TOUCH)
