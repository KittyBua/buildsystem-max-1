#
# Master makefile
#

MAINTAINER := $(shell whoami)
UID := $(shell id -u)
ifeq ($(UID),0)
warn:
	@echo "You are running as root. Do not do this, it is dangerous."
	@echo "Aborting the build. Log in as a regular user and retry."
else

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

local-files:
	@test -e config.local || cp $(HELPERS_DIR)/example.config.local config.local
	@test -e Makefile.local || cp $(HELPERS_DIR)/example.Makefile.local Makefile.local

-include .config
-include config.local
include package/environment-linux.mk
include package/environment-build.mk
include package/environment-target.mk

printenv:
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
ifeq ($(NEWLAYOUT),1)
	@echo -e "IMAGE TYPE        : $(TERM_YELLOW)1 single + multirootfs$(TERM_NORMAL)"
endif
	$(call draw_line);
	@echo -e "LOCAL_N_PLUGIN_BUILD_OPTIONS : $(TERM_GREEN)$(LOCAL_N_PLUGIN_BUILD_OPTIONS)$(TERM_NORMAL)"
	@echo -e "LOCAL_NEUTRINO_BUILD_OPTIONS : $(TERM_GREEN)$(LOCAL_NEUTRINO_BUILD_OPTIONS)$(TERM_NORMAL)"
	@echo -e "LOCAL_NEUTRINO_CFLAGS        : $(TERM_GREEN)$(LOCAL_NEUTRINO_CFLAGS)$(TERM_NORMAL)"
	@echo -e "LOCAL_NEUTRINO_DEPS          : $(TERM_GREEN)$(LOCAL_NEUTRINO_DEPS)$(TERM_NORMAL)"
	@$(call draw_line);
	@make --no-print-directory toolcheck
ifeq ($(MAINTAINER),)
	@echo "##########################################################################"
	@echo "# The MAINTAINER variable is not set. It defaults to your name from the  #"
	@echo "# passwd entry, but this seems to have failed. Please set it in 'config'.#"
	@echo "##########################################################################"
	@echo
endif
	@if ! test -e $(BASE_DIR)/.config; then \
		echo; \
		echo "If you want to create or modify the configuration, run './make.sh'"; \
		echo; \
	fi

help:
	$(call draw_line);
	@echo "a few helpful make targets:"
	@echo "* make crosstool           - build cross toolchain"
	@echo "* make bootstrap           - prepares for building"
	@echo "* make print-targets       - print out all available targets"
	@echo ""
	@echo "later, you might find these useful:"
	@echo "* make update-self         - update the build system"
	@echo "* make update              - update the build system including make distclean"
	@echo ""
	@echo "cleantargets:"
	@echo "make clean                 - Clears everything except kernel."
	@echo "make distclean             - Clears the whole construction."
	@echo ""
	$(call draw_line);

# -----------------------------------------------------------------------------

include package/flashimage.mk
include package/helpers.mk
include $(sort $(wildcard package/*/*/*.mk))
include package/cleantargets.mk
include package/bootstrap.mk

# for local extensions, e.g. special plugins or similar...
-include ./Makefile.local

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

# debug target, if you need that, you know it. If you don't know if you need
# that, you don't need it.
.print-phony:
	@echo $(PHONY)

PHONY += local-files
PHONY += print-targets
PHONY += printenv help all everything
PHONY += update update-self
PHONY += .print-phony
.PHONY: $(PHONY)

endif
