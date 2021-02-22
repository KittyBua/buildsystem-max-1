#
# gnulib
#
GNULIB_VER    = 20140202
GNULIB_DIR    = gnulib-$(GNULIB_VER)-stable
GNULIB_SOURCE = gnulib-$(GNULIB_VER)-stable.tar.gz
GNULIB_SITE   = http://erislabs.net/ianb/projects/gnulib
GNULIB_DEPS   = bootstrap

$(D)/gnulib:
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(TOUCH)
