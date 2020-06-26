#
# python
#
PYTHON_VER    = 2.7.18
PYTHON_DIR    = Python-$(PYTHON_VER)
PYTHON_SOURCE = Python-$(PYTHON_VER).tar.xz
PYTHON_SITE   = https://www.python.org/ftp/python/$(PYTHON_VER)

PYTHON_PATCH  = \
	0001-python.patch \
	0002-python-xcompile.patch \
	0003-python-revert_use_of_sysconfigdata.patch \
	0004-python-pgettext.patch

PYTHON_BASE_DIR    = usr/lib/python$(basename $(PYTHON_VER))
PYTHON_INCLUDE_DIR = usr/include/python$(basename $(PYTHON_VER))

$(D)/python: bootstrap host-python ncurses zlib openssl libffi expat bzip2
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		CONFIG_SITE= \
		$(BUILD_ENV) \
		autoreconf -vfi Modules/_ctypes/libffi $(SILENT_OPT); \
		autoconf $(SILENT_OPT); \
		./configure $(SILENT_OPT) \
			--build=$(BUILD) \
			--host=$(TARGET) \
			--target=$(TARGET) \
			--prefix=/usr \
			--mandir=/.remove \
			--sysconfdir=/etc \
			--enable-shared \
			--with-lto \
			--enable-ipv6 \
			--with-threads \
			--with-pymalloc \
			--with-signal-module \
			--with-wctype-functions \
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
			ac_cv_broken_sem_getvalue=no \
			HOSTPYTHON=$(HOST_DIR)/bin/python$(basename $(PYTHON_VER)) \
			; \
		$(MAKE) $(MAKE_OPTS) \
			PYTHON_MODULES_INCLUDE="$(TARGET_INCLUDE_DIR)" \
			PYTHON_MODULES_LIB="$(TARGET_LIB_DIR)" \
			PYTHON_XCOMPILE_DEPENDENCIES_PREFIX="$(TARGET_DIR)" \
			CROSS_COMPILE_TARGET=yes \
			CROSS_COMPILE=$(TARGET) \
			MACHDEP=linux2 \
			HOSTARCH=$(TARGET) \
			CFLAGS="$(TARGET_CFLAGS)" \
			LDFLAGS="$(TARGET_LDFLAGS)" \
			LD="$(TARGET_CC)" \
			HOSTPYTHON=$(HOST_DIR)/bin/python$(basename $(PYTHON_VER)) \
			HOSTPGEN=$(HOST_DIR)/bin/pgen \
			all DESTDIR=$(TARGET_DIR) \
			; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	ln -sf ../../libpython$(PYTHON_VER_MAJOR).so.1.0 $(TARGET_DIR)/$(PYTHON_BASE_DIR)/config/libpython$(basename $(PYTHON_VER)).so; \
	ln -sf $(TARGET_DIR)/$(PYTHON_INCLUDE_DIR) $(TARGET_DIR)/usr/include/python
	$(PKG_REMOVE)
	$(TOUCH)
