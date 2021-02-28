#
# Master makefile
#
# -----------------------------------------------------------------------------

UID := $(shell id -u)
ifeq ($(UID),0)
warn:
	@echo "You are running as root. Do not do this, it is dangerous."
	@echo "Aborting the build. Log in as a regular user and retry."
else

# This is our default rule, so must come first
default:
	@if ! test -e $(BASE_DIR)/.config; then \
		$(MAKE) config; \
	fi
	@true

# Delete default rules. We don't use them. This saves a bit of time.
.SUFFIXES:

# we want bash as shell
SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
	 else if [ -x /bin/bash ]; then echo /bin/bash; \
	 else echo sh; fi; fi)

# Include some helper macros and variables
include support/misc/utils.mk

# bash prints the name of the directory on 'cd <dir>' if CDPATH is
# set, so unset it here to not cause problems. Notice that the export
# line doesn't affect the environment of $(shell ..) calls.
export CDPATH :=

# Disable top-level parallel build if per-package directories is not
# used. Indeed, per-package directories is necessary to guarantee
# determinism and reproducibility with top-level parallel build.
.NOTPARALLEL:

ifeq ($(KBUILD_VERBOSE),1)
  Q =
ifndef VERBOSE
  VERBOSE = 1
endif
export VERBOSE
else
  Q = @
endif

# kconfig uses CONFIG_SHELL
CONFIG_SHELL := $(SHELL)

export SHELL CONFIG_SHELL Q

ifndef HOSTAR
HOSTAR := ar
endif
ifndef HOSTAS
HOSTAS := as
endif
ifndef HOSTCC
HOSTCC := gcc
HOSTCC := $(shell which $(HOSTCC) || type -p $(HOSTCC) || echo gcc)
endif
HOSTCC_NOCCACHE := $(HOSTCC)
ifndef HOSTCXX
HOSTCXX := g++
HOSTCXX := $(shell which $(HOSTCXX) || type -p $(HOSTCXX) || echo g++)
endif
HOSTCXX_NOCCACHE := $(HOSTCXX)
ifndef HOSTCPP
HOSTCPP := cpp
endif
ifndef HOSTLD
HOSTLD := ld
endif
ifndef HOSTLN
HOSTLN := ln
endif
ifndef HOSTNM
HOSTNM := nm
endif
ifndef HOSTOBJCOPY
HOSTOBJCOPY := objcopy
endif
ifndef HOSTRANLIB
HOSTRANLIB := ranlib
endif
HOSTAR := $(shell which $(HOSTAR) || type -p $(HOSTAR) || echo ar)
HOSTAS := $(shell which $(HOSTAS) || type -p $(HOSTAS) || echo as)
HOSTCPP := $(shell which $(HOSTCPP) || type -p $(HOSTCPP) || echo cpp)
HOSTLD := $(shell which $(HOSTLD) || type -p $(HOSTLD) || echo ld)
HOSTLN := $(shell which $(HOSTLN) || type -p $(HOSTLN) || echo ln)
HOSTNM := $(shell which $(HOSTNM) || type -p $(HOSTNM) || echo nm)
HOSTOBJCOPY := $(shell which $(HOSTOBJCOPY) || type -p $(HOSTOBJCOPY) || echo objcopy)
HOSTRANLIB := $(shell which $(HOSTRANLIB) || type -p $(HOSTRANLIB) || echo ranlib)
SED := $(shell which sed || type -p sed) -i -e

export HOSTAR HOSTAS HOSTCC HOSTCXX HOSTLD
export HOSTCC_NOCCACHE HOSTCXX_NOCCACHE

# silent mode requested?
QUIET := $(if $(findstring s,$(filter-out --%,$(MAKEFLAGS))),-q)

# -----------------------------------------------------------------------------

# workaround unset variables at first start
config:
	@-rm -rf .config
	@clear
	@echo ""
	@echo "                        ()                               "
	@echo "  ____ ___   ___  __  __|/___                            "
	@echo " |  _ \ _ \ / _ \ \ \/ // __|                            "
	@echo " | | | | | | (_| | >  < \__ \\                           "
	@echo " |_| |_| |_|\__,_|/_/\_\|___/                            "
	@echo "  _           _ _     _               _                  "
	@echo " | |         (_) |   | |             | |                 "
	@echo " | |__  _   _ _| | __| |___ _   _ ___| |_____  ___ ___   "
	@echo " |  _ \| | | | | |/ _  / __| | | / __| __/ _ \/ _ v _ \\ "
	@echo " | |_) | |_| | | | (_| \__ \ |_| \__ \ ||  __/ | | | | | "
	@echo " |_.__/\__,_\|_|_|\__,_|___/\__, |___/\__\___|_| |_| |_| "
	@echo "                             __/ |                       "
	@echo "                            |___/                        "
	@echo ""
	@echo "Target receivers:"
	@echo "   1) AX/Mutant HD51"
	@echo "   2) AX/Mutant HD60"
	@echo "   3) AX/Mutant HD61"
	@echo "  11) WWIO BRE2ZE4K"
	@echo "  21) Air Digital Zgemma H7S/C"
	@echo "  31) Edision OS mio 4K"
	@echo "  32) Edision OS mio+ 4K"
	@echo "  41) VU+ Solo 4k"
	@echo "  42) VU+ Duo 4k"
	@echo "  43) VU+ Duo 4k SE"
	@echo "  44) VU+ Ultimo 4k"
	@echo "  45) VU+ Zero 4k"
	@echo "  46) VU+ Uno 4k"
	@echo "  47) VU+ Uno 4k SE"
	@echo "  51) VU+ Duo"
	@read -p "Select your boxmodel? [default: 1] "; \
	boxmodel=$${boxmodel:-1}; \
	case "$$boxmodel" in \
		 1) boxmodel=hd51;; \
		 2) boxmodel=hd60;; \
		 3) boxmodel=hd61;; \
		11) boxmodel=bre2ze4k;; \
		21) boxmodel=h7;; \
		31) boxmodel=osmio4k;; \
		32) boxmodel=osmio4kplus;; \
		41) boxmodel=vusolo4k;; \
		42) boxmodel=vuduo4k;; \
		43) boxmodel=vuduo4kse;; \
		44) boxmodel=vuultimo4k;; \
		45) boxmodel=vuzero4k;; \
		46) boxmodel=vuuno4k;; \
		47) boxmodel=vuuno4kse;; \
		51) boxmodel=vuduo;; \
		 *) boxmodel=hd51;; \
	esac; \
	cp support/config.example .config; \
	sed -i -e "s|^#BOXMODEL = $$boxmodel|BOXMODEL = $$boxmodel|" .config
	@echo ""
	@echo "Toolchain gcc version:"
	@echo "   1) GCC version 6.5.0"
	@echo "   2) GCC version 7.5.0"
	@echo "   3) GCC version 8.4.0"
	@echo "   4) GCC version 9.3.0"
	@echo "   5) GCC version 10.2.0"
	@read -p "Select gcc version? [default: 3] "; \
	bs_gcc_ver=$${bs_gcc_ver:-3}; \
	case "$$bs_gcc_ver" in \
		1) bs_gcc_ver=6.5.0;; \
		2) bs_gcc_ver=7.5.0;; \
		3) bs_gcc_ver=8.4.0;; \
		4) bs_gcc_ver=9.3.0;; \
		5) bs_gcc_ver=10.2.0;; \
		*) bs_gcc_ver=8.4.0;; \
	esac; \
	sed -i -e "s|^#BS_GCC_VER = $$bs_gcc_ver|BS_GCC_VER = $$bs_gcc_ver|" .config
	@echo ""
	@echo "Which Neutrino variant do you want to build:"
	@echo "   1) neutrino-max"
	@echo "   2) neutrino-ddt"
	@echo "   3) neutrino-ni"
	@echo "   4) neutrino-tangos"
	@echo "   5) neutrino-redblue"
	@read -p "Select Image to build? [default: 1] "; \
	flavour=$${flavour:-1}; \
	case "$$flavour" in \
		1) flavour=neutrino-max;; \
		2) flavour=neutrino-ddt;; \
		3) flavour=neutrino-ni;; \
		4) flavour=neutrino-tangos;; \
		5) flavour=neutrino-redblue;; \
		*) flavour=neutrino-max;; \
	esac; \
	sed -i -e "s|^#FLAVOUR = $$flavour|FLAVOUR = $$flavour|" .config
	@echo ""
	@echo "External LCD support:"
	@echo "   1) No external LCD"
	@echo "   2) graphlcd for external LCD"
	@echo "   3) lcd4linux for external LCD"
	@echo "   4) graphlcd and lcd4linux for external LCD (both)"
	@read -p "Select Image to build? [default: 4] "; \
	external_lcd=$${flavour:-4}; \
	case "$$external_lcd" in \
		1) external_lcd=none;; \
		2) external_lcd=graphlcd;; \
		3) external_lcd=lcd4linux;; \
		4) external_lcd=both;; \
		*) external_lcd=both;; \
	esac; \
	sed -i -e "s|^#EXTERNAL_LCD = $$external_lcd|EXTERNAL_LCD = $$external_lcd|" .config
	@echo ""
	@echo "Your next step could be:"
	@echo "   make flashimage"
	@echo "   make ofgimage"
	@echo ""

config.local:
	@cp support/config.local.example $@

Makefile.local:
	@cp support/Makefile.example $@

printenv:
	@clear
	$(call draw_line);
	@echo "Build Environment Variables:"
	@echo "PATH              : `type -p fmt>/dev/null&&echo $(PATH)|sed 's/:/ /g' |fmt -65|sed 's/ /:/g; 2,$$s/^/                  : /;'||echo $(PATH)`"
	@echo "ARCHIVE_DIR       : $(DL_DIR)"
	@echo "BASE_DIR          : $(BASE_DIR)"
	@echo "CROSS_DIR         : $(CROSS_DIR)"
	@echo "RELEASE_DIR       : $(RELEASE_DIR)"
	@echo "RELEASE_IMAGE_DIR : $(IMAGE_DIR)"
	@echo "HOST_DIR          : $(HOST_DIR)"
	@echo "TARGET_DIR        : $(TARGET_DIR)"
	@echo "LINUX_DIR         : $(LINUX_DIR)"
	@echo "MAINTAINER        : $(MAINTAINER)"
	@echo "GNU_HOST_NAME     : $(GNU_HOST_NAME)"
	@echo "GNU_TARGET_NAME   : $(GNU_TARGET_NAME)"
	@echo "TARGET_ARCH       : $(TARGET_ARCH)"
	@echo "BOXTYPE           : $(BOXTYPE)"
	@echo "BOXMODEL          : $(BOXMODEL)"
	@echo "KERNEL_VER        : $(KERNEL_VER)"
	@echo "PARALLEL_JOBS     : $(PARALLEL_JOBS)"
	@echo "CROSS_GCC_VERSION : $(CROSSTOOL_GCC_VER)"
	@echo "OPTIMIZATION      : $(OPTIMIZATIONS)"
	@echo -e "FLAVOUR           : $(TERM_YELLOW)$(FLAVOUR)$(TERM_NORMAL)"
	@echo "EXTERNAL_LCD      : $(EXTERNAL_LCD)"
ifeq ($(LAYOUT),1)
	@echo -e "IMAGE TYPE        : $(TERM_YELLOW)1 single + multirootfs$(TERM_NORMAL)"
endif
	$(call draw_line);
	@echo -e "LOCAL_N_PLUGIN_BUILD_OPTIONS : $(TERM_GREEN)$(LOCAL_N_PLUGIN_BUILD_OPTIONS)$(TERM_NORMAL)"
	@echo -e "LOCAL_NEUTRINO_BUILD_OPTIONS : $(TERM_GREEN)$(LOCAL_NEUTRINO_BUILD_OPTIONS)$(TERM_NORMAL)"
	@echo -e "LOCAL_NEUTRINO_CFLAGS        : $(TERM_GREEN)$(LOCAL_NEUTRINO_CFLAGS)$(TERM_NORMAL)"
	@echo -e "LOCAL_NEUTRINO_DEPS          : $(TERM_GREEN)$(LOCAL_NEUTRINO_DEPS)$(TERM_NORMAL)"
	@$(call draw_line);
	@make --no-print-directory toolcheck
	@if ! test -e $(BASE_DIR)/.config; then \
		echo "If you want to create or modify the configuration, run 'make config'"; \
		echo; \
	fi

help:
	$(call draw_line);
	@echo "a few helpful make targets:"
	@echo "* make config         - configuration build system"
	@echo "* make print-targets  - print out all available targets"
	@echo "* make crosstool      - builds cross toolchain"
	@echo "* make bootstrap      - prepares for building"
	@echo "* make neutrino       - builds Neutrino"
	@echo "* make flashimage     - builds recovery emmc image"
	@echo "* make online-image   - builds recovery online update image"
	@echo ""
	@echo "later, you might find these useful:"
	@echo "* make update-self    - update the build system"
	@echo "* make update         - update the build system including make distclean"
	@echo ""
	@echo "cleantargets:"
	@echo "make clean            - Clears everything except kernel."
	@echo "make distclean        - Clears the whole construction."
	@echo ""
	$(call draw_line);

# -----------------------------------------------------------------------------

update-self:
	git pull

update:
	$(MAKE) distclean
	@if test -d $(BASE_DIR); then \
		cd $(BASE_DIR)/; \
		echo '===================================================================='; \
		echo '      updating buildsystem git repository                           '; \
		echo '===================================================================='; \
		echo; \
		if [ "$(GIT_STASH_PULL)" = "stashpull" ]; then \
			git stash && git stash show -p > ./pull-stash-buildsystem.patch || true && git pull && git stash pop || true; \
		else \
			git pull; \
		fi; \
	fi
	@echo;

# -----------------------------------------------------------------------------

all:
	@echo "'make all' is not a valid target. Please execute 'make print-targets' to display the alternatives."

# target for testing only. not useful otherwise
everything:
	@make $(shell sed -n 's/^\$$.D.\/\(.*\):.*/\1/p' package/target/*/*.mk)

# print all present targets...
print-targets:
	@sed -n 's/^\$$.D.\/\(.*\):.*/\1/p; s/^\([a-z].*\):\( \|$$\).*/\1/p;' \
		`ls -1 package/*/*/*.mk` | \
		sort -u | fold -s -w 65

# -----------------------------------------------------------------------------

-include .config
-include config.local

include package/environment-build.mk
include package/environment-linux.mk
include package/environment-target.mk
include package/flashimage.mk
include package/helpers.mk
include $(sort $(wildcard package/*/*/*.mk))
include package/cleantargets.mk
include package/bootstrap.mk

PATH := $(HOST_DIR)/ccache-bin:$(HOST_DIR)/bin:$(CROSS_DIR)/bin:$(PATH)

# for local extensions, e.g. special plugins or similar...
-include Makefile.local

# -----------------------------------------------------------------------------

# debug target, if you need that, you know it. If you don't know if you need
# that, you don't need it.
.print-phony:
	@echo $(PHONY)

PHONY += config
PHONY += printenv help
PHONY += update update-self
PHONY += all everything print-targets
PHONY += .print-phony
.PHONY: $(PHONY)

endif
