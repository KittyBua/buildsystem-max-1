################################################################################
#
# x264
#
################################################################################

X264_VERSION = git
X264_DIR = x264.git
X264_SOURCE = x264.git
X264_SITE = https://code.videolan.org/videolan

X264_CHECKOUT = 35417dcd

X264_CONF_ENV = \
	AS="$(TARGET_CC)"

X264_CONF_OPTS = \
	--enable-shared \
	--enable-static \
	--enable-pic \
	--disable-avs \
	--disable-lavf \
	--disable-swscale \
	--disable-ffms \
	--disable-opencl

$(D)/x264: | bootstrap
	$(call autotools-package)
