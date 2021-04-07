#
# gnulib
#
GNULIB_VERSION = 20140202
GNULIB_DIR     = gnulib-$(GNULIB_VERSION)-stable
GNULIB_SOURCE  = gnulib-$(GNULIB_VERSION)-stable.tar.gz
GNULIB_SITE    = http://erislabs.net/ianb/projects/gnulib
GNULIB_DEPENDS = bootstrap

$(D)/gnulib:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(TOUCH)
