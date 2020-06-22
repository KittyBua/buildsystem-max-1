#
# host-python3
#
HOST_PYTHON3_VER    = 3.8.2
HOST_PYTHON3_DIR    = Python-$(HOST_PYTHON3_VER)
HOST_PYTHON3_SOURCE = Python-$(HOST_PYTHON3_VER).tar.xz
HOST_PYTHON3_SITE   = https://www.python.org/ftp/python/$(HOST_PYTHON3_VER)

HOST_PYTHON3_BASE_DIR    = lib/python$(basename $(HOST_PYTHON3_VER))
HOST_PYTHON3_INCLUDE_DIR = include/python$(basename $(HOST_PYTHON3_VER))

HOST_PYTHON3_PATCH = \
	0001-Make-the-build-of-pyc-files-conditional.patch \
	0002-Disable-buggy_getaddrinfo-configure-test-when-cross-.patch \
	0003-Add-infrastructure-to-disable-the-build-of-certain-e.patch \
	0004-Adjust-library-header-paths-for-cross-compilation.patch \
	0005-Don-t-look-in-usr-lib-termcap-for-libraries.patch \
	0006-Don-t-add-multiarch-paths.patch \
	0007-Abort-on-failed-module-build.patch \
	0008-Serial-ioctl-workaround.patch \
	0009-Do-not-adjust-the-shebang-of-Python-scripts-for-cros.patch \
	0010-Misc-python-config.sh.in-ensure-sed-invocations-only.patch \
	0011-Override-system-locale-and-set-to-default-when-addin.patch \
	0012-Add-importlib-fix-for-PEP-3147-issue.patch \
	0013-Add-an-option-to-disable-installation-of-test-module.patch \
	0014-Add-an-option-to-disable-pydoc.patch \
	0015-Add-an-option-to-disable-lib2to3.patch \
	0016-Add-option-to-disable-the-sqlite3-module.patch \
	0017-Add-an-option-to-disable-the-tk-module.patch \
	0018-Add-an-option-to-disable-the-curses-module.patch \
	0019-Add-an-option-to-disable-expat.patch \
	0020-Add-an-option-to-disable-CJK-codecs.patch \
	0021-Add-an-option-to-disable-NIS.patch \
	0022-Add-an-option-to-disable-unicodedata.patch \
	0023-Add-an-option-to-disable-IDLE.patch \
	0024-Add-an-option-to-disable-decimal.patch \
	0025-Add-an-option-to-disable-the-ossaudiodev-module.patch \
	0026-Add-an-option-to-disable-openssl-support.patch \
	0027-Add-an-option-to-disable-the-readline-module.patch \
	0028-Add-options-to-disable-zlib-bzip2-and-xz-modules.patch \
	0029-python-config.sh-don-t-reassign-prefix.patch \
	0030-Fix-cross-compiling-the-uuid-module.patch \
	0031-Add-an-option-to-disable-uuid-module.patch \
	0032-fix-building-on-older-distributions.patch \
	0033-configure.ac-fixup-CC-print-multiarch-output-for-mus.patch

$(D)/host-python3: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoconf; \
		CONFIG_SITE= \
		OPT="$(HOST_CFLAGS)" \
		./configure $(SILENT_OPT) \
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
		$(MAKE) all install
	$(PKG_REMOVE)
	$(TOUCH)
