TOOLCHECK  = find-git find-svn find-gzip find-bzip2 find-patch find-gawk
TOOLCHECK += find-makeinfo find-automake find-gcc find-libtool
TOOLCHECK += find-yacc find-flex find-tic find-pkg-config find-help2man
TOOLCHECK += find-cmake find-gperf

find-%:
	@TOOL=$(patsubst find-%,%,$@); \
		type -p $$TOOL >/dev/null || \
		{ echo "required tool $$TOOL missing."; false; }

toolcheck: $(TOOLCHECK) preqs
	@echo "All required tools seem to be installed."
	@echo
	@if test "$(subst /bin/,,$(shell readlink /bin/sh))" != bash; then \
		echo "WARNING: /bin/sh is not linked to bash."; \
		echo "         This configuration might work, but is not supported."; \
		echo; \
	fi

#
# preqs
#
preqs:
	@mkdir -p $(OWN_FILES)/neutrino-hd
	@mkdir -p $(OWN_FILES)/neutrino-hd.$(BOXMODEL)

#
# directories
#
DIRECTORIES_VER = 2020-05-25

$(D)/directories:
	$(START_BUILD)
	mkdir -p $(D)
	mkdir -p $(DL_DIR)
	mkdir -p $(BUILD_DIR)
	mkdir -p $(HOST_DIR)
	mkdir -p $(IMAGE_DIR)
	mkdir -p $(SOURCE_DIR)
	mkdir -p $(HOST_DIR)/{ccache-bin,bin,lib,share}
	mkdir -p $(TARGET_DIR)/{bin,boot,etc,lib,sbin,usr,var}
	mkdir -p $(TARGET_DIR)/etc/{default,init.d,network,ssl,udev}
	mkdir -p $(TARGET_DIR)/etc/default/volatiles
	mkdir -p $(TARGET_DIR)/etc/network/if-{post-down,pre-up,up,down}.d
	mkdir -p $(TARGET_DIR)/lib/firmware
	mkdir -p $(TARGET_DIR)/usr/{bin,include,lib,sbin,share}
	mkdir -p $(TARGET_DIR)/usr/lib/pkgconfig
	mkdir -p $(TARGET_DIR)/var/{bin,etc,lib,spool,tuxbox,volatile}
	mkdir -p $(TARGET_DIR)/var/lib/{alsa,modules,nfs,opkg,urandom}
	$(TOUCH)

#
# cross-libs
#
CROSS_LIBS_VER = 2020-05-25

$(D)/cross-libs: directories $(CROSSTOOL)
	$(START_BUILD)
	if test -e $(CROSS_DIR)/$(GNU_TARGET_NAME)/sys-root/lib; then \
		cp -a $(CROSS_DIR)/$(GNU_TARGET_NAME)/sys-root/lib/*so* $(TARGET_DIR)/lib; \
	fi; \
	if [ "$(TARGET_ARCH)" = "aarch64" ]; then \
		cd ${TARGET_DIR}; ln -sf lib lib64; \
		cd ${TARGET_DIR}/usr; ln -sf lib lib64; \
	fi
	$(TOUCH)

#
# bootstrap
#
BOOTSTRAP  = $(CROSSTOOL)
BOOTSTRAP += directories
BOOTSTRAP += host-ccache
BOOTSTRAP += cross-libs
BOOTSTRAP += host-pkgconf

$(D)/bootstrap: $(BOOTSTRAP)
	@touch $@

#
# image-deps
#
IMAGE_DEPS  =
IMAGE_DEPS += bash
IMAGE_DEPS += procps-ng
IMAGE_DEPS += kmod
IMAGE_DEPS += sysvinit
IMAGE_DEPS += base-files
IMAGE_DEPS += netbase
IMAGE_DEPS += e2fsprogs
#IMAGE_DEPS += jfsutils
IMAGE_DEPS += dosfstools
IMAGE_DEPS += parted
IMAGE_DEPS += gptfdisk
IMAGE_DEPS += hd-idle
IMAGE_DEPS += ntfs-3g
IMAGE_DEPS += tzdata
IMAGE_DEPS += openresolv
IMAGE_DEPS += rpcbind
IMAGE_DEPS += nfs-utils
IMAGE_DEPS += htop
IMAGE_DEPS += vsftpd
IMAGE_DEPS += autofs
IMAGE_DEPS += ethtool
IMAGE_DEPS += ofgwrite
IMAGE_DEPS += wget
IMAGE_DEPS += busybox
IMAGE_DEPS += ncurses
IMAGE_DEPS += fbshot
IMAGE_DEPS += aio-grab
IMAGE_DEPS += dvbsnoop
IMAGE_DEPS += libusb
IMAGE_DEPS += lua
IMAGE_DEPS += luaposix
IMAGE_DEPS += luaexpat
IMAGE_DEPS += luacurl
IMAGE_DEPS += luasocket
IMAGE_DEPS += lua-feedparser
IMAGE_DEPS += luasoap
IMAGE_DEPS += luajson
IMAGE_DEPS += wpa-supplicant
IMAGE_DEPS += wireless-tools
IMAGE_DEPS += udpxy
IMAGE_DEPS += mc
ifeq ($(BOXMODEL),hd60)
IMAGE_DEPS += harfbuzz
endif

$(D)/image-deps: $(IMAGE_DEPS)
	@touch $@

#
# machine-deps
#
MACHINE_DEPS  = kernel
MACHINE_DEPS += kernel-modules-clean
MACHINE_DEPS += $(BOXMODEL)-driver
ifneq ($(BOXMODEL),$(filter $(BOXMODEL),bre2ze4k h7 hd51 hd60 hd61 vuduo))
MACHINE_DEPS += $(BOXMODEL)-libgles
endif
ifeq ($(BOXMODEL),$(filter $(BOXMODEL),vuduo4k vuduo4kse vusolo4k vuultimo4k vuuno4k vuuno4kse vuzero4k))
MACHINE_DEPS += $(BOXMODEL)-platform-util
MACHINE_DEPS += $(BOXMODEL)-vmlinuz-initrd
endif
ifeq ($(BOXMODEL),$(filter $(BOXMODEL),hd60 hd61))
MACHINE_DEPS += $(BOXMODEL)-libs
#MACHINE_DEPS += $(BOXMODEL)-mali-module
endif
ifeq ($(BOXMODEL), $(filter $(BOXMODEL),osmio4k osmio4kplus))
MACHINE_DEPS += wlan-qcom
endif

$(D)/machine-deps: $(MACHINE_DEPS)
	$(LINUX_RUN_DEPMOD)
	@touch $@
