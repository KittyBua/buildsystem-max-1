#
# tzdata
#
TZDATA_VER    = 2020a
TZDATA_DIR    = timezone
TZDATA_SOURCE = tzdata$(TZDATA_VER).tar.gz
TZDATA_SITE   = https://ftp.iana.org/tz/releases

$(D)/tzdata: bootstrap host-tzcode
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	mkdir $(BUILD_DIR)/$(TZDATA_DIR) $(BUILD_DIR)/timezone/zoneinfo
	tar -C $(BUILD_DIR)/$(TZDATA_DIR) -xf $(DL_DIR)/$(TZDATA_SOURCE)
	$(CHDIR)/$(TZDATA_DIR); \
		unset ${!LC_*}; LANG=POSIX; LC_ALL=POSIX; export LANG LC_ALL; \
		$(HOST_DIR)/bin/zic -d zoneinfo.tmp \
			africa antarctica asia australasia \
			europe northamerica southamerica pacificnew \
			etcetera backward; \
		sed -n '/zone=/{s/.*zone="\(.*\)".*$$/\1/; p}' $(PKG_FILES_DIR)/timezone.xml | sort -u | \
		while read x; do \
			find zoneinfo.tmp -type f -name $$x | sort | \
			while read y; do \
				cp -a $$y zoneinfo/$$x; \
			done; \
			test -e zoneinfo/$$x || echo "WARNING: timezone $$x not found."; \
		done; \
		mkdir -p $(TARGET_SHARE_DIR)/zoneinfo $(TARGET_DIR)/etc; \
		cp -a zoneinfo/* $(TARGET_SHARE_DIR)/zoneinfo/
	$(INSTALL_DATA) $(PKG_FILES_DIR)/timezone.xml $(TARGET_DIR)/etc/
	ln -sf /usr/share/zoneinfo/CET $(TARGET_DIR)/etc/localtime
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
