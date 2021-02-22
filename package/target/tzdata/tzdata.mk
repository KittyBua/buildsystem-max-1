#
# tzdata
#
TZDATA_VER    = 2020f
TZDATA_DIR    = timezone
TZDATA_SOURCE = tzdata$(TZDATA_VER).tar.gz
TZDATA_SITE   = https://data.iana.org/time-zones/releases
TZDATA_DEPS   = bootstrap host-zic

TZDATA_ZONELIST = \
	africa antarctica asia australasia \
	europe northamerica southamerica \
	factory etcetera backward

TZDATA_LOCALTIME = CET

$(D)/tzdata:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(MKDIR)/$($(PKG)_DIR)
	$(call EXTRACT,$(PKG_BUILD_DIR))
	$(APPLY_PATCHES)
	$(PKG_CHDIR); \
		unset ${!LC_*}; LANG=POSIX; LC_ALL=POSIX; export LANG LC_ALL; \
		$(HOST_DIR)/bin/zic -b fat -d zoneinfo.tmp $(TZDATA_ZONELIST); \
		sed -n '/zone=/{s/.*zone="\(.*\)".*$$/\1/; p}' $(PKG_FILES_DIR)/timezone.xml | sort -u | \
		while read x; do \
			find zoneinfo.tmp -type f -name $$x | sort | \
			while read y; do \
				test -e $$y && $(INSTALL_DATA) -D $$y $(TARGET_SHARE_DIR)/zoneinfo/$$x; \
			done; \
		done; \
	$(INSTALL_DATA) $(PKG_FILES_DIR)/timezone.xml $(TARGET_DIR)/etc/
	ln -sf /usr/share/zoneinfo/$(TZDATA_LOCALTIME) $(TARGET_DIR)/etc/localtime
	$(REMOVE)
	$(TOUCH)
