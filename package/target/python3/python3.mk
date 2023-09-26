################################################################################
#
# python3
#
################################################################################

PYTHON3_VERSION ?= 3.8.2
PYTHON3_DIR = Python-$(PYTHON3_VERSION)
PYTHON3_SOURCE = Python-$(PYTHON3_VERSION).tar.xz
PYTHON3_SITE = https://www.python.org/ftp/python/$(PYTHON3_VERSION)

PYTHON3_DEPENDS = host-python3 ncurses zlib openssl libffi expat bzip2

# Provided to other packages
PYTHON3_LIB_DIR = usr/lib/python$(basename $(PYTHON3_VERSION))
PYTHON3_INCLUDE_DIR = usr/include/python$(basename $(PYTHON3_VERSION))
PYTHON3_SITE_PACKAGES_DIR = $(PYTHON3_LIB_DIR)/site-packages

PYTHON3_AUTORECONF = YES

PYTHON3_CONF_ENV = \
	ac_cv_have_long_long_format=yes \
	ac_cv_file__dev_ptmx=yes \
	ac_cv_file__dev_ptc=no \
	ac_cv_working_tzset=yes \
	ac_cv_prog_HAS_HG=/bin/false

PYTHON3_CONF_OPTS = \
	--enable-shared \
	--without-ensurepip \
	--without-cxx-main \
	--with-build-python=$(HOST_PYTHON3_BINARY) \
	--with-system-ffi \
	--disable-pydoc \
	--disable-ipv6 \
	--disable-test-modules \
	--disable-tk \
	--disable-nis \
	--disable-idle3 \
	--disable-lib2to3 \
	--disable-berkeleydb \
	--disable-readline

$(D)/python3: | bootstrap
	$(call autotools-package)
