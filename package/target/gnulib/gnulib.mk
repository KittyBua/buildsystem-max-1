#
# gnulib
#
GNULIB_VER    = 20140202
GNULIB_DIR    = gnulib-$(GNULIB_VER)-stable
GNULIB_SOURCE = gnulib-$(GNULIB_VER)-stable.tar.gz
GNULIB_URL    = http://erislabs.net/ianb/projects/gnulib

$(D)/gnulib: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(TOUCH)
