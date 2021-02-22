#
# host-python3
#
HOST_PYTHON3_VER    = 3.8.2
HOST_PYTHON3_DIR    = Python-$(HOST_PYTHON3_VER)
HOST_PYTHON3_SOURCE = Python-$(HOST_PYTHON3_VER).tar.xz
HOST_PYTHON3_SITE   = https://www.python.org/ftp/python/$(HOST_PYTHON3_VER)
HOST_PYTHON3_DEPS   = bootstrap

HOST_PYTHON3_BASE_DIR    = lib/python$(basename $(HOST_PYTHON3_VER))
HOST_PYTHON3_INCLUDE_DIR = include/python$(basename $(HOST_PYTHON3_VER))

$(D)/host-python3:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		autoconf; \
		CONFIG_SITE= \
		OPT="$(HOST_CFLAGS)" \
		./configure \
			--prefix=$(HOST_DIR) \
			--without-ensurepip \
			--without-cxx-main \
			--disable-sqlite3 \
			--disable-tk \
			--with-expat=system \
			--disable-curses \
			--disable-codecs-cjk \
			--disable-nis \
			--enable-unicodedata \
			--disable-test-modules \
			--disable-idle3 \
			--disable-ossaudiodev \
			; \
		$(MAKE); \
		$(MAKE) install
	$(REMOVE)
	$(TOUCH)
