#
# alsa-utils
#
ALSA_UTILS_VER    = 1.2.3
ALSA_UTILS_DIR    = alsa-utils-$(ALSA_UTILS_VER)
ALSA_UTILS_SOURCE = alsa-utils-$(ALSA_UTILS_VER).tar.bz2
ALSA_UTILS_URL    = https://www.alsa-project.org/files/pub/utils

ALSA_UTILS_PATCH  = \
	0001-alsa-utils.patch

$(D)/alsa-utils: bootstrap ncurses alsa-lib
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		sed -ir -r "s/(amidi|aplay|iecset|speaker-test|seq|alsaucm|topology)//g" Makefile.am ;\
		autoreconf -fi -I $(TARGET_DIR)/usr/share/aclocal $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--with-curses=ncurses \
			--enable-silent-rules \
			--with-udev-rules-dir=/.remove \
			--disable-bat \
			--disable-nls \
			--disable-alsatest \
			--disable-alsaconf \
			--disable-alsaloop \
			--disable-xmlto \
			--disable-rst2man \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(INSTALL_DATA) $(PKG_FILES_DIR)/asound.conf $(TARGET_DIR)/etc/asound.conf
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/alsa-state.init $(TARGET_DIR)/etc/init.d/alsa-state
	$(UPDATE-RC.D) alsa-state start 39 S . stop 31 0 6 .
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,aserver)
	rm -f $(addprefix $(TARGET_DIR)/usr/sbin/,alsa-info.sh)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
