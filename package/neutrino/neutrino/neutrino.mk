#
# makefile to build neutrino
#
# -----------------------------------------------------------------------------

ifeq ($(FLAVOUR),neutrino-ddt)
GIT_SITE          ?= https://github.com/Duckbox-Developers
NEUTRINO           = neutrino-ddt
LIBSTB_HAL         = libstb-hal-ddt
NEUTRINO_BRANCH   ?= master
LIBSTB_HAL_BRANCH ?= master
NEUTRINO_PATCH     = neutrino-ddt.patch
LIBSTB_HAL_PATCH   =
else ifeq ($(FLAVOUR),neutrino-max)
GIT_SITE          ?= $(MAX-GIT-GITHUB)
NEUTRINO           = neutrino-max
LIBSTB_HAL         = libstb-hal-max
NEUTRINO_BRANCH   ?= master
LIBSTB_HAL_BRANCH ?= master
NEUTRINO_PATCH     =
LIBSTB_HAL_PATCH   =
else ifeq ($(FLAVOUR),neutrino-ni)
GIT_SITE          ?= https://github.com/neutrino-images
NEUTRINO           = ni-neutrino
LIBSTB_HAL         = ni-libstb-hal
NEUTRINO_BRANCH   ?= master
LIBSTB_HAL_BRANCH ?= master
NEUTRINO_PATCH     = ni-neutrino.patch
LIBSTB_HAL_PATCH   =
else ifeq ($(FLAVOUR),neutrino-tangos)
GIT_SITE          ?= https://github.com/TangoCash
NEUTRINO           = neutrino-tangos
LIBSTB_HAL         = libstb-hal-tangos
NEUTRINO_BRANCH   ?= master
LIBSTB_HAL_BRANCH ?= master
NEUTRINO_PATCH     =
LIBSTB_HAL_PATCH   =
else ifeq ($(FLAVOUR),neutrino-redblue)
GIT_SITE          ?= https://github.com/redblue-pkt
NEUTRINO           = neutrino-redblue
LIBSTB_HAL         = libstb-hal-redblue
NEUTRINO_BRANCH   ?= master
LIBSTB_HAL_BRANCH ?= master
NEUTRINO_PATCH     =
LIBSTB_HAL_PATCH   =
endif

NEUTRINO_OBJ_DIR   = $(BUILD_DIR)/$(NEUTRINO_DIR)

# -----------------------------------------------------------------------------

e2-multiboot:
	touch $(TARGET_DIR)/usr/bin/enigma2
	#
	echo -e "$(FLAVOUR) `sed -n 's/\#define PACKAGE_VERSION "//p' $(NEUTRINO_OBJ_DIR)/config.h | sed 's/"//'` \\\n \\\l\n" > $(TARGET_DIR)/etc/issue
	#
	touch $(TARGET_DIR)/var/lib/opkg/status
	#
	cp -a $(TARGET_DIR)/.version $(TARGET_DIR)/etc/image-version

# -----------------------------------------------------------------------------

OMDB_API_KEY ?=
ifneq ($(strip $(OMDB_API_KEY)),)
N_CONFIG_KEYS += \
	--with-omdb-api-key="$(OMDB_API_KEY)" \
	--disable-omdb-key-manage
endif

TMDB_DEV_KEY ?=
ifneq ($(strip $(TMDB_DEV_KEY)),)
N_CONFIG_KEYS += \
	--with-tmdb-dev-key="$(TMDB_DEV_KEY)" \
	--disable-tmdb-key-manage
endif

YOUTUBE_DEV_KEY ?=
ifneq ($(strip $(YOUTUBE_DEV_KEY)),)
N_CONFIG_KEYS += \
	--with-youtube-dev-key="$(YOUTUBE_DEV_KEY)" \
	--disable-youtube-key-manage
endif

SHOUTCAST_DEV_KEY ?=
ifneq ($(strip $(SHOUTCAST_DEV_KEY)),)
N_CONFIG_KEYS += \
	--with-shoutcast-dev-key="$(SHOUTCAST_DEV_KEY)" \
	--disable-shoutcast-key-manage
endif

WEATHER_DEV_KEY ?=
ifneq ($(strip $(WEATHER_DEV_KEY)),)
N_CONFIG_KEYS += \
	--with-weather-dev-key="$(WEATHER_DEV_KEY)" \
	--disable-weather-key-manage
endif

# -----------------------------------------------------------------------------

NEUTRINO_DEPS  = bootstrap
NEUTRINO_DEPS += machine-deps
NEUTRINO_DEPS += system-tools
NEUTRINO_DEPS += ncurses
NEUTRINO_DEPS += libcurl
NEUTRINO_DEPS += libpng
NEUTRINO_DEPS += libjpeg-turbo
NEUTRINO_DEPS += giflib
NEUTRINO_DEPS += freetype
NEUTRINO_DEPS += alsa-utils
NEUTRINO_DEPS += ffmpeg
NEUTRINO_DEPS += fbshot
NEUTRINO_DEPS += aio-grab
NEUTRINO_DEPS += libsigc
NEUTRINO_DEPS += libdvbsi
NEUTRINO_DEPS += dvbsnoop
NEUTRINO_DEPS += libusb
NEUTRINO_DEPS += pugixml
NEUTRINO_DEPS += openthreads
NEUTRINO_DEPS += lua
NEUTRINO_DEPS += luaposix
NEUTRINO_DEPS += luaexpat
NEUTRINO_DEPS += luacurl
NEUTRINO_DEPS += luasocket
NEUTRINO_DEPS += lua-feedparser
NEUTRINO_DEPS += luasoap
NEUTRINO_DEPS += luajson
NEUTRINO_DEPS += wpa-supplicant
NEUTRINO_DEPS += wireless-tools
NEUTRINO_DEPS += hd-idle
NEUTRINO_DEPS += ntfs-3g
#NEUTRINO_DEPS += jfsutils
NEUTRINO_DEPS += dosfstools
NEUTRINO_DEPS += parted
NEUTRINO_DEPS += gptfdisk
NEUTRINO_DEPS += udpxy
NEUTRINO_DEPS += mc
ifeq ($(BOXMODEL),hd60)
NEUTRINO_DEPS += harfbuzz
endif
NEUTRINO_DEPS += $(LOCAL_NEUTRINO_DEPS)
N_CONFIG_OPTS  = $(LOCAL_NEUTRINO_BUILD_OPTIONS)

ifeq ($(BOXTYPE),armbox)
N_CONFIG_OPTS += --disable-arm-acc
endif
ifeq ($(BOXTYPE),mipsbox)
N_CONFIG_OPTS += --disable-mips-acc
endif


ifeq ($(EXTERNAL_LCD),graphlcd)
N_CONFIG_OPTS += --enable-graphlcd
NEUTRINO_DEPS += graphlcd-base
endif
ifeq ($(EXTERNAL_LCD),lcd4linux)
N_CONFIG_OPTS += --enable-lcd4linux
NEUTRINO_DEPS += lcd4linux
endif
ifeq ($(EXTERNAL_LCD),both)
N_CONFIG_OPTS += --enable-graphlcd
NEUTRINO_DEPS += graphlcd-base
N_CONFIG_OPTS += --enable-lcd4linux
NEUTRINO_DEPS += lcd4linux
endif

# enable ffmpeg audio decoder in neutrino
AUDIODEC = ffmpeg

ifeq ($(AUDIODEC),ffmpeg)
N_CONFIG_OPTS += --enable-ffmpegdec
else
NEUTRINO_DEPS += libid3tag
NEUTRINO_DEPS += libmad

N_CONFIG_OPTS += --with-tremor
NEUTRINO_DEPS += libvorbisidec

N_CONFIG_OPTS += --enable-flac
NEUTRINO_DEPS += flac
endif

NEUTRINO_DEPS += neutrino-channellogos
NEUTRINO_DEPS += neutrino-mediathek
NEUTRINO_DEPS += neutrino-plugins
NEUTRINO_DEPS += xupnpd

# -----------------------------------------------------------------------------

N_CFLAGS       = -Wall -W -Wshadow -pipe -Os -Wno-psabi
N_CFLAGS      += -D__STDC_FORMAT_MACROS
N_CFLAGS      += -D__STDC_CONSTANT_MACROS
N_CFLAGS      += -fno-strict-aliasing
N_CFLAGS      += -funsigned-char
N_CFLAGS      += -ffunction-sections
N_CFLAGS      += -fdata-sections
#N_CFLAGS      += -Wno-deprecated-declarations
N_CFLAGS      += $(LOCAL_NEUTRINO_CFLAGS)

N_CPPFLAGS     = -I$(TARGET_DIR)/usr/include
N_CPPFLAGS    += -ffunction-sections -fdata-sections

# -----------------------------------------------------------------------------

#
# neutrino
#
NEUTRINO_VER    = git
NEUTRINO_DIR    = $(NEUTRINO).git
NEUTRINO_SOURCE = $(NEUTRINO).git
NEUTRINO_SITE   = $(GIT_SITE)

$(D)/neutrino.do_prepare: | $(NEUTRINO_DEPS) libstb-hal
	$(START_BUILD)
	rm -rf $(SOURCE_DIR)/$(NEUTRINO_DIR)
	rm -rf $(SOURCE_DIR)/$(NEUTRINO_DIR).org
	rm -rf $(NEUTRINO_OBJ_DIR)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(SOURCE_DIR))
	(cd $(SOURCE_DIR)/$(NEUTRINO_DIR); git checkout -q $(NEUTRINO_BRANCH);)
	cp -ra $(SOURCE_DIR)/$(NEUTRINO_DIR) $(SOURCE_DIR)/$(NEUTRINO_DIR).org
	$(CD) $(SOURCE_DIR)/$(NEUTRINO_DIR); \
		$(call apply_patches,$(PKG_PATCH))
	@touch $@

$(D)/neutrino.config.status:
	rm -rf $(NEUTRINO_OBJ_DIR)
	test -d $(NEUTRINO_OBJ_DIR) || mkdir -p $(NEUTRINO_OBJ_DIR)
	cd $(NEUTRINO_OBJ_DIR); \
		$(SOURCE_DIR)/$(NEUTRINO_DIR)/autogen.sh $(SILENT_OPT); \
		$(BUILD_ENV) \
		$(SOURCE_DIR)/$(NEUTRINO_DIR)/configure $(SILENT_OPT) \
			--host=$(TARGET) \
			--build=$(BUILD) \
			--prefix=/usr \
			--enable-maintainer-mode \
			--enable-silent-rules \
			\
			--enable-freesatepg \
			--enable-fribidi \
			--enable-giflib \
			--enable-lua \
			--enable-pugixml \
			--enable-reschange \
			\
			$(N_CONFIG_KEYS) \
			\
			$(N_CONFIG_OPTS) \
			\
			--with-tremor \
			--with-target=cdk \
			--with-targetprefix=/usr \
			--with-boxtype=$(BOXTYPE) \
			--with-boxmodel=$(BOXMODEL) \
			--with-stb-hal-includes=$(SOURCE_DIR)/$(LIBSTB_HAL_DIR)/include \
			--with-stb-hal-build=$(LIBSTB_HAL_OBJ_DIR) \
			CFLAGS="$(N_CFLAGS)" CXXFLAGS="$(N_CFLAGS) -std=c++11" CPPFLAGS="$(N_CPPFLAGS)"
		+make $(SOURCE_DIR)/$(NEUTRINO_DIR)/src/gui/version.h
ifeq ($(TINKER_OPTION),0)
	@touch $@
endif

$(D)/neutrino.do_compile:
	$(MAKE) -C $(NEUTRINO_OBJ_DIR) all DESTDIR=$(TARGET_DIR)
	@touch $@

$(D)/neutrino: neutrino.do_prepare neutrino.config.status neutrino.do_compile
	$(MAKE) -C $(NEUTRINO_OBJ_DIR) install DESTDIR=$(TARGET_DIR)
	( \
		echo "distro=$(subst neutrino-,,$(FLAVOUR))"; \
		echo "imagename=Neutrino MP"; \
		echo "imageversion=`sed -n 's/\#define PACKAGE_VERSION "//p' $(NEUTRINO_OBJ_DIR)/config.h | sed 's/"//'`"; \
		echo "homepage=https://github.com/Duckbox-Developers"; \
		echo "creator=$(MAINTAINER)"; \
		echo "docs=https://github.com/Duckbox-Developers"; \
		echo "forum=https://github.com/Duckbox-Developers/neutrino-mp-ddt"; \
		echo "version=0200`date +%Y%m%d%H%M`"; \
		echo "builddate=`date`"; \
		echo "git=BS-rev$(BS_REV)_HAL-rev$(HAL_REV)_NMP-rev$(NMP_REV)"; \
		echo "imagedir=$(BOXMODEL)" \
	) > $(TARGET_DIR)/.version
	make e2-multiboot
ifeq ($(FLAVOUR),$(filter $(FLAVOUR),neutrino-max neutrino-ni))
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/start_neutrino1 $(TARGET_DIR)/etc/init.d/start_neutrino
else
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/start_neutrino2 $(TARGET_DIR)/etc/init.d/start_neutrino
endif
	$(TOUCH)
	make neutrino-release

# -----------------------------------------------------------------------------

version.h: $(SOURCE_DIR)/$(NEUTRINO_DIR)/src/gui/version.h
$(SOURCE_DIR)/$(NEUTRINO_DIR)/src/gui/version.h:
	@rm -f $@
	echo '#define BUILT_DATE "'`date`'"' > $@
	@if test -d $(SOURCE_DIR)/$(LIBSTB_HAL_DIR); then \
		echo '#define VCS "BS-rev$(BS_REV)_HAL-rev$(HAL_REV)_NMP-rev$(NMP_REV)"' >> $@; \
	fi

# -----------------------------------------------------------------------------

neutrino-clean:
	rm -f $(D)/neutrino
	rm -f $(D)/neutrino.config.status
	rm -f $(SOURCE_DIR)/$(NEUTRINO_DIR)/src/gui/version.h
	cd $(NEUTRINO_OBJ_DIR); \
		$(MAKE) -C $(NEUTRINO_OBJ_DIR) distclean

neutrino-distclean:
	rm -rf $(NEUTRINO_OBJ_DIR)
	rm -f $(D)/neutrino
	rm -f $(D)/neutrino.config.status
	rm -f $(D)/neutrino.do_compile
	rm -f $(D)/neutrino.do_prepare

neutrino-uninstall:
	-make -C $(NEUTRINO_OBJ_DIR) uninstall DESTDIR=$(TARGET_DIR)

# -----------------------------------------------------------------------------

PHONY += $(TARGET_DIR)/.version
PHONY += $(SOURCE_DIR)/$(NEUTRINO_DIR)/src/gui/version.h
