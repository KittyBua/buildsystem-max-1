################################################################################
#
# host-python3
#
################################################################################

PYTHON3_VERSION = 3.8.2
PYTHON3_DIR = Python-$(PYTHON3_VERSION)
PYTHON3_SOURCE = Python-$(PYTHON3_VERSION).tar.xz
PYTHON3_SITE = https://www.python.org/ftp/python/$(PYTHON3_VERSION)

HOST_PYTHON3_BINARY = $(HOST_DIR)/bin/python3

HOST_PYTHON3_LIB_DIR = lib/python$(basename $(PYTHON3_VERSION))
HOST_PYTHON3_INCLUDE_DIR = include/python$(basename $(PYTHON3_VERSION))
HOST_PYTHON3_SITEPACKAGES_DIR = $(HOST_PYTHON3_LIB_DIR)/site-packages

HOST_PYTHON3_AUTORECONF = YES

HOST_PYTHON3_CONF_OPTS = \
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
	--disable-ossaudiodev

$(D)/host-python3: | bootstrap
	$(call host-autotools-package)
