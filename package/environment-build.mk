#
# set up build environment for other makefiles
#
#SHELL := $(SHELL) -x

ifndef MAKE
MAKE := make
endif
ifndef HOSTMAKE
HOSTMAKE = $(MAKE)
endif
HOSTMAKE := $(shell which $(HOSTMAKE) || type -p $(HOSTMAKE) || echo make)

# If BS_JLEVEL is 0, scale the maximum concurrency with the number of
# CPUs. An additional job is used in order to keep processors busy
# while waiting on I/O.
# If the number of processors is not available, assume one.
BS_JLEVEL ?= 0
ifeq ($(BS_JLEVEL),0)
PARALLEL_JOBS := $(shell echo \
	$$((1 + `getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1`)))
else
PARALLEL_JOBS := $(BS_JLEVEL)
endif

MAKE1 := $(HOSTMAKE) -j1
override MAKE = $(HOSTMAKE) \
	$(if $(findstring j,$(filter-out --%,$(MAKEFLAGS))),,-j$(PARALLEL_JOBS))

MAKEFLAGS += --no-print-directory

# -----------------------------------------------------------------------------

BASE_DIR     := ${CURDIR}
DL_DIR       ?= $(HOME)/Archive
BUILD_DIR     = $(BASE_DIR)/build_tmp
ifeq ($(NEWLAYOUT), 1)
RELEASE_DIR   = $(BASE_DIR)/release/linuxrootfs1
else
RELEASE_DIR   = $(BASE_DIR)/release
endif
DEPS_DIR      = $(BASE_DIR)/.deps
D             = $(DEPS_DIR)
TARGET_DIR    = $(BASE_DIR)/root
SOURCE_DIR    = $(BASE_DIR)/build_source
IMAGE_DIR     = $(BASE_DIR)/release_image
OWN_FILES    ?= $(BASE_DIR)/own-files
CROSS_DIR     = $(BASE_DIR)/cross/$(TARGET_ARCH)-$(CROSSTOOL_GCC_VER)-kernel-$(KERNEL_VER)
HOST_DIR      = $(BASE_DIR)/host
STAGING_DIR   = $(CROSS_DIR)/$(GNU_TARGET_NAME)/sys-root

MAINTAINER   ?= $(shell whoami)

TARGET_LIB_DIR      = $(TARGET_DIR)/usr/lib
TARGET_INCLUDE_DIR  = $(TARGET_DIR)/usr/include
TARGET_FIRMWARE_DIR = $(TARGET_DIR)/lib/firmware
TARGET_SHARE_DIR    = $(TARGET_DIR)/usr/share

# -----------------------------------------------------------------------------

pkgname         = $(subst -config,,$(subst -upgradeconfig,,$(basename $(@F))))
PKG             = $(call UPPERCASE,$(pkgname))
PKG_BUILD_DIR   = $(BUILD_DIR)/$($(PKG)_DIR)
PKG_FILES_DIR   = $(BASE_DIR)/package/*/$(pkgname)/files
PKG_PATCHES_DIR = $(BASE_DIR)/package/*/$(pkgname)/patches

CD_BUILD_DIR    = $(CD) $(PKG_BUILD_DIR)

# -----------------------------------------------------------------------------

CCACHE     = /usr/bin/ccache
CCACHE_DIR = $(HOME)/.ccache-bs-$(TARGET_ARCH)-max
export CCACHE_DIR

# -----------------------------------------------------------------------------

BOXMODEL = hd51
ifeq ($(BOXMODEL),bre2ze4k)
  BOXNAME     = "WWIO BRE2ZE4K"
  BOXTYPE     = armbox
  TARGET_ARCH = arm
else ifeq ($(BOXMODEL),h7)
  BOXNAME     = "Air Digital Zgemma H7S/C"
  BOXTYPE     = armbox
  TARGET_ARCH = arm
else ifeq ($(BOXMODEL),hd51)
  BOXNAME     = "AX/Mut@nt HD51"
  BOXTYPE     = armbox
  TARGET_ARCH = arm
else ifeq ($(BOXMODEL),hd60)
  BOXNAME     = "AX/Mut@nt HD60"
  BOXTYPE     = armbox
  TARGET_ARCH = arm
else ifeq ($(BOXMODEL),hd61)
  BOXNAME     = "AX/Mut@nt HD61"
  BOXTYPE     = armbox
  TARGET_ARCH = arm
else ifeq ($(BOXMODEL),osmio4k)
  BOXNAME     = "Edison Os mio 4k"
  BOXTYPE     = armbox
  TARGET_ARCH = arm
else ifeq ($(BOXMODEL),osmio4kplus)
  BOXNAME     = "Edison Os mio+ 4K"
  BOXTYPE     = armbox
  TARGET_ARCH = arm
else ifeq ($(BOXMODEL),vusolo4k)
  BOXNAME     = "VU+ Solo 4K"
  BOXTYPE     = armbox
  TARGET_ARCH = arm
else ifeq ($(BOXMODEL),vuduo4k)
  BOXNAME     = "VU+ Duo 4K"
  BOXTYPE     = armbox
  TARGET_ARCH = arm
else ifeq ($(BOXMODEL),vuduo4kse)
  BOXNAME     = "VU+ Duo 4K SE"
  BOXTYPE     = armbox
  TARGET_ARCH = arm
else ifeq ($(BOXMODEL),vuultimo4k)
  BOXNAME     = "VU+ Ultimo 4K"
  BOXTYPE     = armbox
  TARGET_ARCH = arm
else ifeq ($(BOXMODEL),vuzero4k)
  BOXNAME     = "VU+ Zero 4K"
  BOXTYPE     = armbox
  TARGET_ARCH = arm
else ifeq ($(BOXMODEL),vuuno4k)
  BOXNAME     = "VU+ Uno 4K"
  BOXTYPE     = armbox
  TARGET_ARCH = arm
else ifeq ($(BOXMODEL),vuuno4kse)
  BOXNAME     = "VU+ Uno 4K SE"
  BOXTYPE     = armbox
  TARGET_ARCH = arm
else ifeq ($(BOXMODEL),vuduo)
  BOXNAME     = "VU+ Duo"
  BOXTYPE     = mipsbox
  TARGET_ARCH = mips
endif

BS_GCC_VER ?= 8.4.0
ifeq ($(BS_GCC_VER),6.5.0)
  CROSSTOOL_GCC_VER = gcc-6.5.0
else ifeq ($(BS_GCC_VER),7.5.0)
  CROSSTOOL_GCC_VER = gcc-7.5.0
else ifeq ($(BS_GCC_VER),8.4.0)
  CROSSTOOL_GCC_VER = gcc-8.4.0
else ifeq ($(BS_GCC_VER),9.3.0)
  CROSSTOOL_GCC_VER = gcc-9.3.0
else ifeq ($(BS_GCC_VER),10.2.0)
  CROSSTOOL_GCC_VER = gcc-10.2.0
endif

ifeq ($(TARGET_ARCH),arm)
  GNU_TARGET_NAME = arm-cortex-linux-gnueabihf
  TARGET_CPU      = armv7ve
  TARGET_ABI      = -march=$(TARGET_CPU) -mtune=cortex-a15 -mfpu=neon-vfpv4 -mfloat-abi=hard
  TARGET_ENDIAN   = little
else ifeq ($(TARGET_ARCH),aarch64)
  GNU_TARGET_NAME = aarch64-unknown-linux-gnu
  TARGET_CPU      =
  TARGET_ABI      =
  TARGET_ENDIAN   = big
else ifeq ($(TARGET_ARCH),mips)
  GNU_TARGET_NAME = mipsel-unknown-linux-gnu
  TARGET_CPU      = mips32
  TARGET_ABI      = -march=$(TARGET_CPU) -mtune=mips32
  TARGET_ENDIAN   = little
endif

OPTIMIZATIONS ?= size
ifeq ($(OPTIMIZATIONS),size)
  TARGET_OPTIMIZATION  = -pipe -Os
  TARGET_EXTRA_CFLAGS  = -ffunction-sections -fdata-sections
  TARGET_EXTRA_LDFLAGS = -Wl,--gc-sections
else ifeq ($(OPTIMIZATIONS),normal)
  TARGET_OPTIMIZATION  = -pipe -O2
  TARGET_EXTRA_CFLAGS  =
  TARGET_EXTRA_LDFLAGS =
else ifeq ($(OPTIMIZATIONS),debug)
  TARGET_OPTIMIZATION  = -O0 -g
  TARGET_EXTRA_CFLAGS  =
  TARGET_EXTRA_LDFLAGS =
endif

ifeq ($(BOXMODEL),$(filter $(BOXMODEL),bre2ze4k h7 hd51))
  LAYOUT      ?= 1
  LAYOUT_SWAP ?= 1
else ifeq ($(BOXMODEL),$(filter $(BOXMODEL),hd60 hd61))
  LAYOUT      ?= 1
  LAYOUT_SWAP ?= 0
endif
ifeq ($(BOXMODEL),$(filter $(BOXMODEL),vusolo4k vuduo4k vuduo4kse vuultimo4k vuzero4k vuuno4k vuuno4kse))
  VU_MULTIBOOT ?= 1
endif

# -----------------------------------------------------------------------------

TARGET_CFLAGS   = $(TARGET_OPTIMIZATION) $(TARGET_ABI) $(TARGET_EXTRA_CFLAGS) -I$(TARGET_INCLUDE_DIR)
TARGET_CPPFLAGS = $(TARGET_CFLAGS)
TARGET_CXXFLAGS = $(TARGET_CFLAGS)
TARGET_LDFLAGS  = -L$(TARGET_DIR)/lib -L$(TARGET_DIR)/usr/lib -Wl,-O1 -Wl,-rpath -Wl,/usr/lib -Wl,-rpath-link -Wl,${TARGET_DIR}/usr/lib $(TARGET_EXTRA_LDFLAGS)

#TARGET_CROSS    = $(CROSS_DIR)/bin/$(GNU_TARGET_NAME)-
TARGET_CROSS    = $(GNU_TARGET_NAME)-

# Define TARGET_xx variables for all common binutils/gcc
TARGET_AR       = $(TARGET_CROSS)ar
TARGET_AS       = $(TARGET_CROSS)as
TARGET_CC       = $(TARGET_CROSS)gcc
TARGET_CPP      = $(TARGET_CROSS)cpp
TARGET_CXX      = $(TARGET_CROSS)g++
TARGET_LD       = $(TARGET_CROSS)ld
TARGET_NM       = $(TARGET_CROSS)nm
TARGET_RANLIB   = $(TARGET_CROSS)ranlib
TARGET_READELF  = $(TARGET_CROSS)readelf
TARGET_OBJCOPY  = $(TARGET_CROSS)objcopy
TARGET_OBJDUMP  = $(TARGET_CROSS)objdump
TARGET_STRIP    = $(TARGET_CROSS)strip

GNU_HOST_NAME  := $(shell support/gnuconfig/config.guess)

HOST_CPPFLAGS   = -I$(HOST_DIR)/include
HOST_CFLAGS    ?= -O2
HOST_CFLAGS    += $(HOST_CPPFLAGS)
HOST_CXXFLAGS  += $(HOST_CFLAGS)
HOST_LDFLAGS   += -L$(HOST_DIR)/lib -Wl,-rpath,$(HOST_DIR)/lib

# -----------------------------------------------------------------------------

# search path(s) for all prerequisites
VPATH = $(DEPS_DIR)

# -----------------------------------------------------------------------------

PKG_CONFIG        = $(HOST_DIR)/bin/$(GNU_TARGET_NAME)-pkg-config
PKG_CONFIG_PATH   = $(TARGET_LIB_DIR)/pkgconfig
PKG_CONFIG_LIBDIR = $(TARGET_LIB_DIR)/pkgconfig

# -----------------------------------------------------------------------------

# build helper variables
CD    = set -e; cd
MKDIR = mkdir -p $(BUILD_DIR)
STRIP = $(GNU_TARGET_NAME)-strip

DATE           = $(shell date '+%Y-%m-%d_%H.%M')
TINKER_OPTION ?= 0

INSTALL      = install
INSTALL_CONF = $(INSTALL) -m 0600
INSTALL_DATA = $(INSTALL) -m 0644
INSTALL_EXEC = $(INSTALL) -m 0755
INSTALL_COPY = cp -a

define INSTALL_EXIST # (source, dest)
	if [ -d $(dir $(1)) ]; then \
		$(INSTALL) -d $(2); \
		$(INSTALL_COPY) $(1) $(2); \
	fi
endef

GET-GIT-ARCHIVE = support/scripts/get-git-archive.sh
GET-GIT-SOURCE  = support/scripts/get-git-source.sh
GET-SVN-SOURCE  = support/scripts/get-svn-source.sh
UPDATE-RC.D     = support/scripts/update-rc.d -r $(TARGET_DIR)

# -----------------------------------------------------------------------------

MAKE_OPTS = \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	AR="$(TARGET_AR)" \
	AS="$(TARGET_AS)" \
	LD="$(TARGET_LD)" \
	NM="$(TARGET_NM)" \
	CC="$(TARGET_CC)" \
	GCC="$(TARGET_CC)" \
	CPP="$(TARGET_CPP)" \
	CXX="$(TARGET_CXX)" \
	RANLIB="$(TARGET_RANLIB)" \
	READELF="$(TARGET_READELF)" \
	STRIP="$(TARGET_STRIP)" \
	OBJCOPY="$(TARGET_OBJCOPY)" \
	OBJDUMP="$(TARGET_OBJDUMP)" \
	ARCH=$(TARGET_ARCH)

TARGET_CONFIGURE_ENV = \
	$(MAKE_OPTS) \
	CPPFLAGS="$(TARGET_CPPFLAGS)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	CXXFLAGS="$(TARGET_CXXFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)"

TARGET_CONFIGURE_ENV += \
	PKG_CONFIG_PATH="" \
	PKG_CONFIG_LIBDIR=$(PKG_CONFIG_LIBDIR) \
	PKG_CONFIG_SYSROOT_DIR=$(TARGET_DIR) \
	$($(PKG)_CONF_ENV)

TARGET_CONFIGURE_OPTS = \
	--build=$(GNU_HOST_NAME) \
	--host=$(GNU_TARGET_NAME) \
	--target=$(GNU_TARGET_NAME) \
	--program-prefix= \
	--program-suffix= \
	--prefix=$(prefix) \
	--exec_prefix=$(exec_prefix) \
	--bindir=$(bindir) \
	--datadir=$(datadir) \
	--includedir=$(includedir) \
	--infodir=$(REMOVE_infodir) \
	--libdir=$(libdir) \
	--libexecdir=$(libexecdir) \
	--localstatedir=$(localstatedir) \
	--mandir=$(REMOVE_mandir) \
	--oldincludedir=$(oldincludedir) \
	--sbindir=$(sbindir) \
	--sharedstatedir=$(sharedstatedir) \
	--sysconfdir=$(sysconfdir) \
	$($(PKG)_CONF_OPTS)

CONFIGURE = \
	if [ "$($(PKG)_AUTORECONF)" == "YES" ]; then \
	  autoreconf -fi; \
	fi; \
	test -f ./configure || ./autogen.sh && \
	CONFIG_SITE=/dev/null \
	$(TARGET_CONFIGURE_ENV) \
	./configure \
	$(TARGET_CONFIGURE_OPTS)

# -----------------------------------------------------------------------------

CMAKE_OPTS = \
	-DBUILD_SHARED_LIBS=ON \
	-DENABLE_STATIC=OFF \
	-DCMAKE_BUILD_TYPE="None" \
	-DCMAKE_SYSTEM_NAME="Linux" \
	-DCMAKE_SYSTEM_PROCESSOR="$(TARGET_ARCH)" \
	-DCMAKE_INSTALL_PREFIX="/usr" \
	-DCMAKE_INSTALL_DOCDIR="$(REMOVE_docdir)" \
	-DCMAKE_INSTALL_MANDIR="$(REMOVE_mandir)" \
	-DCMAKE_PREFIX_PATH="$(TARGET_DIR)" \
	-DCMAKE_INCLUDE_PATH="$(TARGET_INCLUDE_DIR)" \
	-DCMAKE_C_COMPILER="$(TARGET_CC)" \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -DNDEBUG" \
	-DCMAKE_CPP_COMPILER="$(TARGET_CPP)" \
	-DCMAKE_CPP_FLAGS="$(TARGET_CFLAGS) -DNDEBUG" \
	-DCMAKE_CXX_COMPILER="$(TARGET_CXX)" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CFLAGS) -DNDEBUG" \
	-DCMAKE_LINKER="$(TARGET_LD)" \
	-DCMAKE_AR="$(TARGET_AR)" \
	-DCMAKE_AS="$(TARGET_AS)" \
	-DCMAKE_NM="$(TARGET_NM)" \
	-DCMAKE_OBJCOPY="$(TARGET_OBJCOPY)" \
	-DCMAKE_OBJDUMP="$(TARGET_OBJDUMP)" \
	-DCMAKE_RANLIB="$(TARGET_RANLIB)" \
	-DCMAKE_READELF="$(TARGET_READELF)" \
	-DCMAKE_STRIP="$(TARGET_STRIP)" \
	$($(PKG)_CONF_OPTS)

CMAKE = \
	rm -f CMakeCache.txt; \
	cmake . --no-warn-unused-cli $(CMAKE_OPTS)

# -----------------------------------------------------------------------------

TUXBOX_CUSTOMIZE = [ -x support/scripts/$(notdir $@)-local.sh ] && \
	support/scripts/$(notdir $@)-local.sh \
	$(RELEASE_DIR) \
	$(TARGET_DIR) \
	$(BASE_DIR) \
	$(SOURCE_DIR) \
	$(IMAGE_DIR) \
	$(BOXMODEL) \
	$(FLAVOUR) \
	$(DATE) \
	|| true
