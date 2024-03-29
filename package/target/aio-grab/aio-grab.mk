################################################################################
#
# aio-grab
#
################################################################################

AIO_GRAB_VERSION = master
AIO_GRAB_DIR = aio-grab.git
AIO_GRAB_SOURCE = aio-grab.git
AIO_GRAB_SITE = https://github.com/oe-alliance
AIO_GRAB_SITE_METHOD = git

AIO_GRAB_DEPENDS = zlib libpng libjpeg-turbo

AIO_GRAB_AUTORECONF = YES

AIO_GRAB_CONF_OPTS = \
	--bindir=$(base_bindir) \
	--enable-silent-rules

$(D)/aio-grab: | bootstrap
	$(call autotools-package)
