################################################################################
#
# x264
#
################################################################################

X264_VERSION = 35417dc
X264_DIR = x264.git
X264_SOURCE = x264.git
X264_SITE = https://code.videolan.org/videolan
X264_SITE_METHOD = git

X264_CONF_ENV = \
	AS="$(TARGET_CC)"

X264_CONF_OPTS = \
	--enable-shared \
	--enable-static \
	--enable-pic \
	--disable-asm \
	--disable-avs \
	--disable-lavf \
	--disable-swscale \
	--disable-ffms \
	--disable-opencl

$(D)/x264: | bootstrap
	$(call autotools-package)
