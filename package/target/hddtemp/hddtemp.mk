#
# hddtemp
#
HDDTEMP_VERSION = 0.3-beta15
HDDTEMP_DIR     = hddtemp-$(HDDTEMP_VERSION)
HDDTEMP_SOURCE  = hddtemp-$(HDDTEMP_VERSION).tar.bz2
HDDTEMP_SITE    = http://savannah.c3sl.ufpr.br/hddtemp
HDDTEMP_DEPENDS = bootstrap libiconv

HDDTEMP_CONF_OPTS = \
	LIBS="-liconv" \
	--datadir=$(REMOVE_datarootdir) \
	--with-db_path=/usr/share/misc/hddtemp.db \
	--disable-dependency-tracking

$(D)/hddtemp:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(INSTALL_DATA) -D $(PKG_FILES_DIR)/hddtemp.db $(TARGET_DIR)/usr/share/misc/hddtemp.db
	ln -sf /usr/share/misc/hddtemp.db $(TARGET_DIR)/etc/hddtemp.db
	$(REMOVE)
	$(TOUCH)
