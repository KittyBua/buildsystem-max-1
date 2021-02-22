#
# makefile to keep buildsystem helpers
#
# -----------------------------------------------------------------------------

# Strip quotes and then whitespaces
qstrip = $(strip $(subst ",,$(1)))

# Variables for use in Make constructs
comma := ,
empty :=
space := $(empty) $(empty)

# Reverse the orders of words in a list. Again, inspired by the gmsl
# 'reverse' macro.
reverse = $(if $(1),$(call reverse,$(wordlist 2,$(words $(1)),$(1))) $(firstword $(1)))

# Sanitize macro cleans up generic strings so it can be used as a filename
# and in rules. Particularly useful for VCS version strings, that can contain
# slashes, colons (OK in filenames but not in rules), and spaces.
sanitize = $(subst $(space),_,$(subst :,_,$(subst /,_,$(strip $(1)))))

# Utility functions for 'find'
# findfileclauses(filelist) => -name 'X' -o -name 'Y'
findfileclauses = $(call notfirstword,$(patsubst %,-o -name '%',$(1)))
# finddirclauses(base, dirlist) => -path 'base/dirX' -o -path 'base/dirY'
finddirclauses = $(call notfirstword,$(patsubst %,-o -path '$(1)/%',$(2)))

# Miscellaneous utility functions
# notfirstword(wordlist): returns all but the first word in wordlist
notfirstword = $(wordlist 2,$(words $(1)),$(1))

# build a comma-separated list of quoted items, from a space-separated
# list of unquoted items:   a b c d  -->  "a", "b", "c", "d"
make-comma-list = $(subst $(space),$(comma)$(space),$(patsubst %,"%",$(strip $(1))))

# build a comma-separated list of single quoted items, from a space-separated
# list of unquoted items:   a b c d  -->  'a', 'b', 'c', 'd'
make-sq-comma-list = $(subst $(space),$(comma)$(space),$(patsubst %,'%',$(strip $(1))))

# Needed for the foreach loops to loop over the list of hooks, so that
# each hook call is properly separated by a newline.
define sep


endef

PERCENT = %
QUOTE = '

define PRINTF
	printf '$(subst $(sep),\n,\
		$(subst $(PERCENT),$(PERCENT)$(PERCENT),\
			$(subst $(QUOTE),$(QUOTE)\$(QUOTE)$(QUOTE),\
				$(subst \,\\,$(1)))))\n'
endef

# -----------------------------------------------------------------------------

# download archives into archives directory
WGET_DOWNLOAD = wget --no-check-certificate -q --show-progress --progress=bar:force -t3 -T60 -c -P

define DOWNLOAD
	@( \
	if [ "$($(PKG)_VER)" == "git" ]; then \
	  $(call MESSAGE,"Downloading") ; \
	  $(GET-GIT-SOURCE) $($(PKG)_SITE)/$($(PKG)_SOURCE) $(DL_DIR)/$($(PKG)_SOURCE); \
	else \
	  if [ ! -f $(DL_DIR)/$($(PKG)_SOURCE) ]; then \
	    $(call MESSAGE,"Downloading") ; \
	    $(WGET_DOWNLOAD) $(DL_DIR) $($(PKG)_SITE)/$(1); \
	  fi; \
	fi; \
	)
	$(foreach p,$(ALL_DOWNLOADS),@$(WGET_DOWNLOAD) $(DL_DIR) $(p)$(sep))
endef

ALL_DOWNLOADS = \
	$(foreach p,$($(PKG)_PATCH) $($(PKG)_EXTRA_DOWNLOADS),$(if $(findstring ://,$(p)),$(p),$($(PKG)_SITE)/$(p)))

# github(user,package,version): returns site of GitHub repository
github = https://github.com/$(1)/$(2)/archive/$(3)

# -----------------------------------------------------------------------------

# unpack archives into build directory
define EXTRACT
	@$(call MESSAGE,"Extracting")
	@( \
	case $($(PKG)_SOURCE) in \
	  *.tar | *.tar.bz2 | *.tbz | *.tar.gz | *.tgz | *.tar.xz | *.txz) \
	    tar -xf ${DL_DIR}/$($(PKG)_SOURCE) -C ${1}; \
	    ;; \
	  *.zip) \
	    unzip -o -q ${DL_DIR}/$($(PKG)_SOURCE) -d ${1}; \
	    ;; \
	  *.git) \
	    cp -a -t ${1} $(DL_DIR)/$($(PKG)_SOURCE); \
	    if test -z $($(PKG)_CHECKOUT); then \
	      $(call MESSAGE,"use original head"); \
	    else \
	      $(call MESSAGE,"git checkout $($(PKG)_CHECKOUT)"); \
	      $(CD) ${1}/$($(PKG)_DIR); git checkout -q $($(PKG)_CHECKOUT); \
	    fi; \
	    ;; \
	  *) \
	    $(call MESSAGE,"Cannot extract $($(PKG)_SOURCE)"); \
	    false ;; \
	esac \
	)
endef

# -----------------------------------------------------------------------------

$(PKG)_PRE_PATCH_HOOKS  ?=
$(PKG)_POST_PATCH_HOOKS ?=

APPLY_PATCH = helpers/apply-patches.sh $(if $(QUIET),-s)

# apply patch sets
define APPLY_PATCHES
	@$(call MESSAGE,"Patching")
	$(foreach hook,$($(PKG)_PRE_PATCH_HOOKS),$(call $(hook))$(sep))
	$(foreach p,$($(PKG)_PATCH),$(APPLY_PATCH) $(PKG_BUILD_DIR) $(DL_DIR) $(notdir $(p))$(sep))
	@( \
	for P in $(PKG_PATCHES_DIR); do \
	  if test -d $${P}; then \
	    if test -d $${P}/$($(PKG)_VER); then \
	      $(APPLY_PATCH) $(PKG_BUILD_DIR) $${P}/$($(PKG)_VER) \*.patch \*.patch.$(TARGET_ARCH) || exit 1; \
	    else \
	      $(APPLY_PATCH) $(PKG_BUILD_DIR) $${P} \*.patch \*.patch.$(TARGET_ARCH) \*.patch.$(FLAVOUR) || exit 1; \
	    fi; \
	  fi; \
	done; \
	)
	$(foreach hook,$($(PKG)_POST_PATCH_HOOKS),$(call $(hook))$(sep))
endef

define APPLY_PATCHES_S
	@$(call MESSAGE,"Patching")
	$(foreach hook,$($(PKG)_PRE_PATCH_HOOKS),$(call $(hook))$(sep))
	@( \
	for P in $(PKG_PATCHES_DIR); do \
	  if test -d $${P}; then \
	    $(APPLY_PATCH) $(SOURCE_DIR)/$(1) $${P} \*.patch \*.patch.$(FLAVOUR) || exit 1; \
	  fi; \
	done; \
	)
	$(foreach hook,$($(PKG)_POST_PATCH_HOOKS),$(call $(hook))$(sep))
endef

# -----------------------------------------------------------------------------

# rewrite libtool libraries
REWRITE_LIBTOOL_RULES = \
	"s,^libdir=.*,libdir='$(1)',; \
	 s,\(^dependency_libs='\| \|-L\|^dependency_libs='\)/usr/lib,\ $(1),g"

REWRITE_LIBTOOL_TAG = rewritten=1

define REWRITE_LIBTOOL
	@$(call MESSAGE,"Fixing libtool files")
	@( \
	for la in $$(find $(1) -name "*.la" -type f); do \
	  if ! grep -q "$(REWRITE_LIBTOOL_TAG)" $${la}; then \
	    echo -e "$(TERM_YELLOW)Rewriting $${la#$(1)/}$(TERM_NORMAL)"; \
	    $(SED) $(REWRITE_LIBTOOL_RULES) $${la}; \
	    echo -e "\n# Adapted to buildsystem\n$(REWRITE_LIBTOOL_TAG)" >> $${la}; \
	  fi; \
	done; \
	)
endef

# rewrite libtool libraries automatically
REWRITE_LIBTOOL_LA = $(call REWRITE_LIBTOOL,$(TARGET_LIB_DIR))

# -----------------------------------------------------------------------------

# rewrite pkg-config files
REWRITE_CONFIG_RULES = \
	"s,^prefix=.*,prefix='$(TARGET_DIR)/usr',; \
	 s,^exec_prefix=.*,exec_prefix='$(TARGET_DIR)/usr',; \
	 s,^libdir=.*,libdir='$(TARGET_LIB_DIR)',; \
	 s,^includedir=.*,includedir='$(TARGET_INCLUDE_DIR)',"

REWRITE_CONFIG = @$(SED) $(REWRITE_CONFIG_RULES)

# -----------------------------------------------------------------------------

define START_BUILD
	@make $($(PKG)_DEPS)
	@$(call MESSAGE,"Building")
endef

define TOUCH
	@$(call MESSAGE,"Building completed")
	@touch $@
	@echo ""
endef

# clean up
define REMOVE
	@$(call MESSAGE,"Remove")
	@( \
	rm -rf $(PKG_BUILD_DIR); \
	)
endef

# MESSAGE Macro -- display a message in bold type
MESSAGE = echo "$(TERM_BOLD)>>> $(pkgname) $($(PKG)_VER) $(call qstrip,$(1))$(TERM_RESET)"
TERM_BOLD := $(shell tput smso 2>/dev/null)
TERM_RESET := $(shell tput rmso 2>/dev/null)

# -----------------------------------------------------------------------------

#
# Manipulation of .config files based on the Kconfig infrastructure.
# Used by the BusyBox package, the Linux kernel package, and more.
#

define KCONFIG_ENABLE_OPT # (option, file)
	$(SED) "/\\<$(1)\\>/d" $(2)
	echo '$(1)=y' >> $(2)
endef

define KCONFIG_SET_OPT # (option, value, file)
	$(SED) "/\\<$(1)\\>/d" $(3)
	echo '$(1)=$(2)' >> $(3)
endef

define KCONFIG_DISABLE_OPT # (option, file)
	$(SED) "/\\<$(1)\\>/d" $(2)
	echo '# $(1) is not set' >> $(2)
endef

# -----------------------------------------------------------------------------

#
# Case conversion macros.
#

[LOWER] := a b c d e f g h i j k l m n o p q r s t u v w x y z - .
[UPPER] := A B C D E F G H I J K L M N O P Q R S T U V W X Y Z _ _

define caseconvert-helper
$(1) = $$(strip \
	$$(eval __tmp := $$(1))\
	$(foreach c, $(2),\
		$$(eval __tmp := $$(subst $(word 1,$(subst :, ,$c)),$(word 2,$(subst :, ,$c)),$$(__tmp))))\
	$$(__tmp))
endef

$(eval $(call caseconvert-helper,UPPERCASE,$(join $(addsuffix :,$([LOWER])),$([UPPER]))))
$(eval $(call caseconvert-helper,LOWERCASE,$(join $(addsuffix :,$([UPPER])),$([LOWER]))))

# -----------------------------------------------------------------------------

# BS Revision
BS_REV=$(shell cd $(BASE_DIR); git log | grep "^commit" | wc -l)
# Neutrino mp Revision
NMP_REV=$(shell cd $(SOURCE_DIR)/$(NEUTRINO_DIR); git log | grep "^commit" | wc -l)
# libstb-hal Revision
HAL_REV=$(shell cd $(SOURCE_DIR)/$(LIBSTB_HAL_DIR); git log | grep "^commit" | wc -l)

# -----------------------------------------------------------------------------

#
# $(1) = title
# $(2) = color
#	0 - Black
#	1 - Red
#	2 - Green
#	3 - Yellow
#	4 - Blue
#	5 - Magenta
#	6 - Cyan
#	7 - White
# $(3) = left|center|right
#
define draw_line
	@\
	printf '%.0s-' {1..$(shell tput cols)}; \
	if test "$(1)"; then \
		cols=$(shell tput cols); \
		length=$(shell echo $(1) | awk '{print length}'); \
		case "$(3)" in \
			*right)  let indent="length + 1" ;; \
			*center) let indent="cols - (cols - length) / 2" ;; \
			*left|*) let indent="cols" ;; \
		esac; \
		tput cub $$indent; \
		test "$(2)" && printf $$(tput setaf $(2)); \
		printf '$(1)'; \
		test "$(2)" && printf $$(tput sgr0); \
	fi; \
	echo
endef

# -----------------------------------------------------------------------------

# python helpers
HOST_PYTHON_BUILD = \
	CC="$(HOSTCC)" \
	CFLAGS="$(HOST_CFLAGS)" \
	LDFLAGS="$(HOST_LDFLAGS)" \
	LDSHARED="$(HOSTCC) -shared" \
	PYTHONPATH=$(HOST_DIR)/$(HOST_PYTHON3_BASE_DIR)/site-packages \
	$(HOST_DIR)/bin/python3 ./setup.py -q build --executable=/usr/python

HOST_PYTHON_INSTALL = \
	CC="$(HOSTCC)" \
	CFLAGS="$(HOST_CFLAGS)" \
	LDFLAGS="$(HOST_LDFLAGS)" \
	LDSHARED="$(HOSTCC) -shared" \
	PYTHONPATH=$(HOST_DIR)/$(HOST_PYTHON3_BASE_DIR)/site-packages \
	$(HOST_DIR)/bin/python3 ./setup.py -q install --root=$(HOST_DIR) --prefix=

PYTHON_BUILD = \
	CC="$(TARGET_CC)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	LDSHARED="$(TARGET_CC) -shared" \
	PYTHONPATH=$(TARGET_DIR)/$(PYTHON_BASE_DIR)/site-packages \
	CPPFLAGS="$(TARGET_CPPFLAGS) -I$(TARGET_DIR)/$(PYTHON_INCLUDE_DIR)" \
	$(HOST_DIR)/bin/python ./setup.py -q build --executable=/usr/bin/python

PYTHON_INSTALL = \
	CC="$(TARGET_CC)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	LDSHARED="$(TARGET_CC) -shared" \
	PYTHONPATH=$(TARGET_DIR)/$(PYTHON_BASE_DIR)/site-packages \
	CPPFLAGS="$(TARGET_CPPFLAGS) -I$(TARGET_DIR)/$(PYTHON_INCLUDE_DIR)" \
	$(HOST_DIR)/bin/python ./setup.py -q install --root=$(TARGET_DIR) --prefix=/usr

# -----------------------------------------------------------------------------

# target for testing only. not useful otherwise
everything:
	@make $(shell sed -n 's/^\$$.D.\/\(.*\):.*/\1/p' package/target/*/*.mk)

# -----------------------------------------------------------------------------

# print all present targets...
print-targets:
	@sed -n 's/^\$$.D.\/\(.*\):.*/\1/p; s/^\([a-z].*\):\( \|$$\).*/\1/p;' \
		`ls -1 package/*/*/*.mk` | \
		sort -u | fold -s -w 65

# -----------------------------------------------------------------------------

#
ifeq ($(GITSSH),1)
MAX-GIT-GITHUB = git@github.com:MaxWiesel
URL_1          = https://github.com/MaxWiesel
URL_2          = $(MAX-GIT-GITHUB)
else
MAX-GIT-GITHUB = https://github.com/MaxWiesel
URL_1          = git@github.com:MaxWiesel
URL_2          = $(MAX-GIT-GITHUB)
endif

REPOSITORIES = \
	. \
	$(DL_DIR)/libstb-hal-max.git \
	$(DL_DIR)/neutrino-mp-max.git \
	$(DL_DIR)/neutrino-plugins.git \
	$(DL_DIR)/ofgwrite-nmp.git

switch-url:
	for repo in $(REPOSITORIES); do \
		$(SED) 's|url = $(URL_1)|url = $(URL_2)|' $$repo/.git/config; \
	done

# -----------------------------------------------------------------------------

#
rewrite-test:
	@printf "$(TERM_YELLOW)---> create rewrite-libdir.txt ... "
	$(shell grep ^libdir $(TARGET_DIR)/usr/lib/*.la > $(BUILD_DIR)/rewrite-libdir.txt)
	@printf "done\n$(TERM_NORMAL)"
	@printf "$(TERM_YELLOW)---> create rewrite-pkgconfig.txt ... "
	$(shell grep ^prefix $(TARGET_DIR)/usr/lib/pkgconfig/* > $(BUILD_DIR)/rewrite-pkgconfig.txt)
	@printf "done\n$(TERM_NORMAL)"
	@printf "$(TERM_YELLOW)---> create rewrite-dependency_libs.txt ... "
	$(shell grep ^dependency_libs $(TARGET_DIR)/usr/lib/*.la > $(BUILD_DIR)/rewrite-dependency_libs.txt)
	@printf "done\n$(TERM_NORMAL)"

# -----------------------------------------------------------------------------

#
neutrino-patch:
	@printf "$(TERM_YELLOW)---> create $(NEUTRINO) patch ... $(TERM_NORMAL)"
	$(shell cd $(SOURCE_DIR) && diff -Nur --exclude-from=$(HELPERS_DIR)/diff-exclude $(NEUTRINO_DIR).org $(NEUTRINO_DIR) > $(BUILD_DIR)/$(NEUTRINO)-$(DATE).patch)
	@printf "$(TERM_YELLOW)done\n$(TERM_NORMAL)"

libstb-hal-patch:
	@printf "$(TERM_YELLOW)---> create $(LIBSTB_HAL) patch ... $(TERM_NORMAL)"
	$(shell cd $(SOURCE_DIR) && diff -Nur --exclude-from=$(HELPERS_DIR)/diff-exclude $(LIBSTB_HAL_DIR).org $(LIBSTB_HAL_DIR) > $(BUILD_DIR)/$(LIBSTB_HAL)-$(DATE).patch)
	@printf "$(TERM_YELLOW)done\n$(TERM_NORMAL)"
