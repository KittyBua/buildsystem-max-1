################################################################################
#
# ffmpeg
#
################################################################################

FFMPEG_VERSION ?= 4.4.1
FFMPEG_DIR = ffmpeg-$(FFMPEG_VERSION)
FFMPEG_SOURCE = ffmpeg-$(FFMPEG_VERSION).tar.xz
FFMPEG_SITE = http://www.ffmpeg.org/releases

FFMPEG_DEPENDS = openssl zlib bzip2 freetype libvorbis libass rtmpdump libxml2 x264

FFMPEG_CONF_OPTS = \
	--disable-ffplay \
	--disable-ffprobe \
	\
	--disable-doc \
	--disable-htmlpages \
	--disable-manpages \
	--disable-podpages \
	--disable-txtpages \
	\
	--disable-altivec \
	--disable-amd3dnow \
	--disable-amd3dnowext \
	--disable-armv5te \
	--disable-avx \
	--disable-avx2 \
	--disable-fast-unaligned \
	--disable-fma3 \
	--disable-fma4 \
	--disable-inline-asm \
	--disable-mmx \
	--disable-mmxext \
	--disable-sse \
	--disable-sse2 \
	--disable-sse3 \
	--disable-sse4 \
	--disable-sse42 \
	--disable-ssse3 \
	--disable-xop \
	--disable-x86asm \
	\
	--disable-dxva2 \
	--disable-vaapi \
	--disable-vdpau \
	\
	--disable-muxers \
	--enable-muxer=adts \
	--enable-muxer=apng \
	--enable-muxer=asf \
	--enable-muxer=flac \
	--enable-muxer=h261 \
	--enable-muxer=h263 \
	--enable-muxer=h264 \
	--enable-muxer=hevc \
	--enable-muxer=image2 \
	--enable-muxer=image2pipe \
	--enable-muxer=m4v \
	--enable-muxer=matroska \
	--enable-muxer=mjpeg \
	--enable-muxer=mp3 \
	--enable-muxer=mp4 \
	--enable-muxer=mpeg1video \
	--enable-muxer=mpeg2video \
	--enable-muxer=mpegts \
	--enable-muxer=ogg \
	--enable-muxer=rawvideo \
	--enable-muxer=webm \
	--enable-muxer=webm_chunk \
	--enable-muxer=webm_dash_manifest \
	\
	--disable-parsers \
	--enable-parser=aac \
	--enable-parser=aac_latm \
	--enable-parser=ac3 \
	--enable-parser=dca \
	--enable-parser=dvbsub \
	--enable-parser=dvd_nav \
	--enable-parser=dvdsub \
	--enable-parser=flac \
	--enable-parser=h264 \
	--enable-parser=hevc \
	--enable-parser=mjpeg \
	--enable-parser=mpeg4video \
	--enable-parser=mpegaudio \
	--enable-parser=mpegvideo \
	--enable-parser=png \
	--enable-parser=vc1 \
	--enable-parser=vorbis \
	--enable-parser=vp8 \
	--enable-parser=vp9 \
	\
	--disable-encoders \
	--enable-encoder=aac \
	--enable-encoder=eac3 \
	--enable-encoder=h261 \
	--enable-encoder=h263 \
	--enable-encoder=h263p \
	--enable-encoder=jpeg2000 \
	--enable-encoder=jpegls \
	--enable-encoder=ljpeg \
	--enable-encoder=libvorbis \
	--enable-encoder=mjpeg \
	--enable-encoder=mpeg1video \
	--enable-encoder=mpeg2video \
	--enable-encoder=mpeg4 \
	--enable-encoder=png \
	--enable-encoder=rawvideo \
	--enable-encoder=wmav2 \
	\
	--disable-decoders \
	--enable-decoder=aac \
	--enable-decoder=aac_latm \
	--enable-decoder=adpcm_ct \
	--enable-decoder=adpcm_g722 \
	--enable-decoder=adpcm_g726 \
	--enable-decoder=adpcm_g726le \
	--enable-decoder=adpcm_ima_amv \
	--enable-decoder=adpcm_ima_oki \
	--enable-decoder=adpcm_ima_qt \
	--enable-decoder=adpcm_ima_rad \
	--enable-decoder=adpcm_ima_wav \
	--enable-decoder=adpcm_ms \
	--enable-decoder=adpcm_sbpro_2 \
	--enable-decoder=adpcm_sbpro_3 \
	--enable-decoder=adpcm_sbpro_4 \
	--enable-decoder=adpcm_swf \
	--enable-decoder=adpcm_yamaha \
	--enable-decoder=alac \
	--enable-decoder=ape \
	--enable-decoder=ass \
	--enable-decoder=atrac1 \
	--enable-decoder=atrac3 \
	--enable-decoder=atrac3p \
	--enable-decoder=cook \
	--enable-decoder=dca \
	--enable-decoder=dsd_lsbf \
	--enable-decoder=dsd_lsbf_planar \
	--enable-decoder=dsd_msbf \
	--enable-decoder=dsd_msbf_planar \
	--enable-decoder=dvbsub \
	--enable-decoder=dvdsub \
	--enable-decoder=eac3 \
	--enable-decoder=evrc \
	--enable-decoder=flac \
	--enable-decoder=flv \
	--enable-decoder=vorbis \
	--enable-decoder=g723_1 \
	--enable-decoder=g729 \
	--enable-decoder=gif \
	--enable-decoder=h261 \
	--enable-decoder=h263 \
	--enable-decoder=h263i \
	--enable-decoder=h264 \
	--enable-decoder=hevc \
	--enable-decoder=iac \
	--enable-decoder=imc \
	--enable-decoder=jpeg2000 \
	--enable-decoder=jpegls \
	--enable-decoder=mace3 \
	--enable-decoder=mace6 \
	--enable-decoder=metasound \
	--enable-decoder=mjpeg \
	--enable-decoder=mlp \
	--enable-decoder=movtext \
	--enable-decoder=mp1 \
	--enable-decoder=mp2 \
	--enable-decoder=mp3 \
	--enable-decoder=mp3adu \
	--enable-decoder=mp3adufloat \
	--enable-decoder=mp3float \
	--enable-decoder=mp3on4 \
	--enable-decoder=mp3on4float \
	--enable-decoder=mpeg1video \
	--enable-decoder=mpeg2video \
	--enable-decoder=mpeg4 \
	--enable-decoder=nellymoser \
	--enable-decoder=opus \
	--enable-decoder=pcm_alaw \
	--enable-decoder=pcm_bluray \
	--enable-decoder=pcm_dvd \
	--enable-decoder=pcm_f32be \
	--enable-decoder=pcm_f32le \
	--enable-decoder=pcm_f64be \
	--enable-decoder=pcm_f64le \
	--enable-decoder=pcm_lxf \
	--enable-decoder=pcm_mulaw \
	--enable-decoder=pcm_s16be \
	--enable-decoder=pcm_s16be_planar \
	--enable-decoder=pcm_s16le \
	--enable-decoder=pcm_s16le_planar \
	--enable-decoder=pcm_s24be \
	--enable-decoder=pcm_s24daud \
	--enable-decoder=pcm_s24le \
	--enable-decoder=pcm_s24le_planar \
	--enable-decoder=pcm_s32be \
	--enable-decoder=pcm_s32le \
	--enable-decoder=pcm_s32le_planar \
	--enable-decoder=pcm_s8 \
	--enable-decoder=pcm_s8_planar \
	--enable-decoder=pcm_u16be \
	--enable-decoder=pcm_u16le \
	--enable-decoder=pcm_u24be \
	--enable-decoder=pcm_u24le \
	--enable-decoder=pcm_u32be \
	--enable-decoder=pcm_u32le \
	--enable-decoder=pcm_u8 \
	--enable-decoder=pgssub \
	--enable-decoder=png \
	--enable-decoder=qcelp \
	--enable-decoder=qdm2 \
	--enable-decoder=ra_144 \
	--enable-decoder=ra_288 \
	--enable-decoder=ralf \
	--enable-decoder=s302m \
	--enable-decoder=shorten \
	--enable-decoder=sipr \
	--enable-decoder=sonic \
	--enable-decoder=srt \
	--enable-decoder=ssa \
	--enable-decoder=subrip \
	--enable-decoder=subviewer \
	--enable-decoder=subviewer1 \
	--enable-decoder=tak \
	--enable-decoder=text \
	--enable-decoder=truehd \
	--enable-decoder=truespeech \
	--enable-decoder=tta \
	--enable-decoder=vorbis \
	--enable-decoder=wavpack \
	--enable-decoder=wmalossless \
	--enable-decoder=wmapro \
	--enable-decoder=wmav1 \
	--enable-decoder=wmav2 \
	--enable-decoder=wmavoice \
	--enable-decoder=xsub \
	\
	--disable-demuxers \
	--enable-demuxer=aac \
	--enable-demuxer=ac3 \
	--enable-demuxer=apng \
	--enable-demuxer=ass \
	--enable-demuxer=avi \
	--enable-demuxer=dash \
	--enable-demuxer=dts \
	--enable-demuxer=eac3 \
	--enable-demuxer=ffmetadata \
	--enable-demuxer=flac \
	--enable-demuxer=flv \
	--enable-demuxer=gif \
	--enable-demuxer=h264 \
	--enable-demuxer=hls \
	--enable-demuxer=live_flv \
	--enable-demuxer=image2 \
	--enable-demuxer=image2pipe \
	--enable-demuxer=image_bmp_pipe \
	--enable-demuxer=image_jpeg_pipe \
	--enable-demuxer=image_jpegls_pipe \
	--enable-demuxer=image_png_pipe \
	--enable-demuxer=m4v \
	--enable-demuxer=matroska \
	--enable-demuxer=mjpeg \
	--enable-demuxer=mov \
	--enable-demuxer=mp3 \
	--enable-demuxer=mpegps \
	--enable-demuxer=mpegts \
	--enable-demuxer=mpegtsraw \
	--enable-demuxer=mpegvideo \
	--enable-demuxer=mpjpeg \
	--enable-demuxer=ogg \
	--enable-demuxer=pcm_s16be \
	--enable-demuxer=pcm_s16le \
	--enable-demuxer=rawvideo \
	--enable-demuxer=realtext \
	--enable-demuxer=rm \
	--enable-demuxer=rtp \
	--enable-demuxer=rtsp \
	--enable-demuxer=srt \
	--enable-demuxer=vc1 \
	--enable-demuxer=wav \
	--enable-demuxer=webm_dash_manifest \
	\
	--disable-filters \
	--enable-filter=drawtext \
	--enable-filter=overlay \
	--enable-filter=scale \
	\
	--enable-libx264 \
	--enable-encoder=libx264 \
	--enable-gpl \
	\
	--enable-bsfs \
	--enable-bzlib \
	--enable-libass \
	--enable-libfreetype \
	--enable-librtmp \
	--enable-libxml2 \
	--enable-libvorbis \
	--enable-network \
	--enable-nonfree \
	--enable-openssl \
	--enable-zlib \
	--disable-iconv \
	\
	--disable-xlib \
	--disable-libxcb \
	--disable-libxcb-shm \
	--disable-libxcb-xfixes \
	--disable-libxcb-shape \
	\
	--disable-debug \
	--disable-runtime-cpudetect \
	--enable-pic \
	--enable-pthreads \
	--enable-small \
	--enable-stripping \
	--enable-swresample \
	--enable-hardcoded-tables

ifeq ($(TARGET_ARCH), arm)
FFMPEG_CONF_OPTS += \
	--enable-armv6 \
	--enable-armv6t2 \
	--enable-neon \
	--enable-vfp \
	--cpu=cortex-a15
endif
ifeq ($(TARGET_ARCH), aarch64)
FFMPEG_CONF_OPTS += \
	--enable-armv8 \
	--enable-vfp \
	--enable-neon
endif
ifeq ($(TARGET_ARCH), mips)
FFMPEG_CONF_OPTS += \
	--disable-mips32r5 \
	--disable-mipsdsp \
	--disable-mipsdspr2 \
	--disable-loongson2 \
	--disable-loongson3 \
	--disable-mmi \
	--disable-msa \
	--disable-msa2 \
	--disable-neon \
	--disable-vfp
endif

FFMPEG_CONF_OPTS += \
	--prefix=$(prefix) \
	--datadir=$(REMOVE_datarootdir) \
	--enable-cross-compile \
	--cross-prefix=$(TARGET_CROSS) \
	--arch=$(TARGET_ARCH) \
	--target-os=linux \
	--disable-debug \
	--disable-stripping \
	--disable-static \
	--enable-shared \
	--pkg-config="$(PKG_CONFIG)" \
	--extra-cflags="$(TARGET_CFLAGS) -I$(TARGET_INCLUDE_DIR)/libxml2" \
	--extra-ldflags="$(TARGET_LDFLAGS) -lrt "

define FFMPEG_CONFIGURE_CMDS
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE_ENV) $($(PKG)_CONF_ENV) ./configure $($(PKG)_CONF_OPTS)
endef

$(D)/ffmpeg: | bootstrap
	$(call autotools-package)
