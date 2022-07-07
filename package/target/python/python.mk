################################################################################
#
# python
#
################################################################################

PYTHON_VERSION = 2.7.18
PYTHON_DIR = Python-$(PYTHON_VERSION)
PYTHON_SOURCE = Python-$(PYTHON_VERSION).tar.xz
PYTHON_SITE = https://www.python.org/ftp/python/$(PYTHON_VERSION)

PYTHON_DEPENDS = bootstrap host-python ncurses zlib openssl libffi expat bzip2

PYTHON_LIB_DIR     = usr/lib/python$(basename $(PYTHON_VERSION))
PYTHON_INCLUDE_DIR = usr/include/python$(basename $(PYTHON_VERSION))
PYTHON_SITEPACKAGES_DIR = $(PYTHON_LIB_DIR)/site-packages

PYTHON_CONF_ENV = \
	ac_sys_system=Linux \
	ac_sys_release=2 \
	ac_cv_file__dev_ptmx=yes \
	ac_cv_file__dev_ptc=no \
	ac_cv_have_long_long_format=yes \
	ac_cv_no_strict_aliasing_ok=yes \
	ac_cv_pthread=yes \
	ac_cv_cxx_thread=yes \
	ac_cv_sizeof_off_t=8 \
	ac_cv_have_chflags=no \
	ac_cv_have_lchflags=no \
	ac_cv_py_format_size_t=yes \
	ac_cv_broken_sem_getvalue=no

PYTHON_CONF_OPTS = \
	--enable-shared \
	--with-lto \
	--enable-ipv6 \
	--with-threads \
	--with-pymalloc \
	--with-signal-module \
	--with-wctype-functions

define PYTHON_EXECUTE_AUTOTOOLS
	$(CHDIR)/$($(PKG)_DIR); \
		CONFIG_SITE= \
		autoreconf -vfi Modules/_ctypes/libffi; \
		autoconf
endef
PYTHON_PRE_CONFIGURE_HOOKS += PYTHON_EXECUTE_AUTOTOOLS

$(D)/python:
	$(call PREPARE)
	$(call TARGET_CONFIGURE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) \
			PYTHON_MODULES_INCLUDE="$(TARGET_INCLUDE_DIR)" \
			PYTHON_MODULES_LIB="$(TARGET_LIB_DIR)" \
			PYTHON_XCOMPILE_DEPENDENCIES_PREFIX="$(TARGET_DIR)" \
			CROSS_COMPILE_TARGET=yes \
			CROSS_COMPILE=$(GNU_TARGET_NAME) \
			MACHDEP=linux2 \
			HOSTARCH=$(GNU_TARGET_NAME) \
			CFLAGS="$(TARGET_CFLAGS)" \
			LDFLAGS="$(TARGET_LDFLAGS)" \
			LD="$(TARGET_CC)" \
			NM="$(TARGET_NM)" \
			AR="$(TARGET_AR)" \
			AS="$(TARGET_AS)" \
			HOSTPYTHON=$(HOST_DIR)/bin/python$(basename $(PYTHON_VERSION)) \
			HOSTPGEN=$(HOST_DIR)/bin/pgen \
			all DESTDIR=$(TARGET_DIR) \
			; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	ln -sf ../../libpython$(PYTHON_VERSION_MAJOR).so.1.0 $(TARGET_DIR)/$(PYTHON_LIB_DIR)/config/libpython$(basename $(PYTHON_VERSION)).so; \
	ln -sf $(TARGET_DIR)/$(PYTHON_INCLUDE_DIR) $(TARGET_DIR)/usr/include/python
	$(call TARGET_FOLLOWUP)
