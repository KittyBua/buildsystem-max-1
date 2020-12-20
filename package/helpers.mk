#
# makefile to keep buildsystem helpers
#
# -----------------------------------------------------------------------------

# BS Revision
BS_REV=$(shell cd $(BASE_DIR); git log | grep "^commit" | wc -l)
# Neutrino mp Revision
NMP_REV=$(shell cd $(SOURCE_DIR)/$(NEUTRINO_DIR); git log | grep "^commit" | wc -l)
# libstb-hal Revision
HAL_REV=$(shell cd $(SOURCE_DIR)/$(LIBSTB_HAL_DIR); git log | grep "^commit" | wc -l)

# -----------------------------------------------------------------------------

#
# apply patch sets
#
define apply_patches
	l=$(strip $(2)); test -z $$l && l=1; \
	for i in $(1); do \
		if [ -d $$i ]; then \
			for p in $$i/*; do \
				echo -e "$(TERM_YELLOW)Applying patch $(PKG_NAME):$(TERM_NORMAL) $${p#$(PKG_PATCHES_DIR)/}"; \
				if [ $${p:0:1} == "/" ]; then \
					patch -p$$l -i $$p; \
				else \
					patch -p$$l -i $(PKG_PATCHES_DIR)/$$p; \
				fi; \
			done; \
		else \
			echo -e "$(TERM_YELLOW)Applying patch $(PKG_NAME):$(TERM_NORMAL) $${i#$(PKG_PATCHES_DIR)/}"; \
			if [ $${i:0:1} == "/" ]; then \
				patch -p$$l -i $$i; \
			else \
				patch -p$$l -i $(PKG_PATCHES_DIR)/$$i; \
			fi; \
		fi; \
	done
endef

# apply patch sets automatically
APPLY_PATCHES = $(call apply_patches,$(PKG_PATCHES_DIR))
PATCH = patch -p1 -s

# -----------------------------------------------------------------------------

#
# download archives into archives directory
#
define PKG_DOWNLOAD
	$(SILENT)if [ $(PKG_VER) == "git" ]; then \
		$(GET-GIT-SOURCE) $(PKG_SITE)/$(PKG_SOURCE) $(DL_DIR)/$(PKG_SOURCE); \
	else \
		if [ ! -f $(DL_DIR)/$(PKG_SOURCE) ]; then \
			wget --no-check-certificate -q --show-progress --progress=bar:force -t3 -T60 -c -P $(DL_DIR) $(PKG_SITE)/$(1); \
		fi; \
	fi
endef

#
# github(user,package,version): returns site of GitHub repository
#
github = https://github.com/$(1)/$(2)/archive/$(3)

# -----------------------------------------------------------------------------

#
# unpack archives into build directory
#
define PKG_UNPACK
	$(SILENT)( \
	case ${PKG_SOURCE} in \
		*.tar | *.tar.bz2 | *.tbz | *.tar.gz | *.tgz | *.tar.xz | *.txz) \
			tar -xf ${DL_DIR}/${PKG_SOURCE} -C ${1}; \
			;; \
		*.zip) \
			unzip -o -q ${DL_DIR}/${PKG_SOURCE} -d ${1}; \
			;; \
		*.git) \
			cp -a -t ${1} $(DL_DIR)/$(PKG_SOURCE); \
			;; \
		*) \
			printf "$(TERM_RED)Cannot extract ${PKG_SOURCE}$(TERM_NORMAL) \n"; \
			false ;; \
	esac \
	)
endef

# -----------------------------------------------------------------------------

define START_BUILD
	$(SILENT)echo ""; \
	echo -e "$(TERM_GREEN)Start building$(TERM_NORMAL) \nName    : $(PKG_NAME) \nVersion : $(PKG_VER) \nSource  : $(PKG_SOURCE)"; \
	echo ""
endef

define TOUCH
	$(SILENT)touch $@; echo -e "$(TERM_GREEN) $(PKG_NAME) building completed$(TERM_NORMAL)"; \
	echo ""; \
	$(call draw_line)
endef

# -----------------------------------------------------------------------------

#
# rewrite libtool libraries
#
REWRITE_LIBTOOL_RULES = \
	sed -i \
	-e "s,^libdir=.*,libdir='$(TARGET_LIB_DIR)'," \
	-e "s,\(^dependency_libs='\| \|-L\|^dependency_libs='\)/usr/lib,\ $(TARGET_LIB_DIR),g"

REWRITE_LIBTOOL = \
	$(REWRITE_LIBTOOL_RULES) $(TARGET_LIB_DIR)

define rewrite_libtool
	$(SILENT)cd $(TARGET_LIB_DIR); \
	for la in *.la; do \
		if ! grep -q "rewritten=1" $${la}; then \
			echo -e "$(TERM_YELLOW)Rewriting $${la}$(TERM_NORMAL)"; \
			$(REWRITE_LIBTOOL)/$${la}; \
			echo -e "\n# Adapted to buildsystem\nrewritten=1" >> $${la}; \
		fi; \
	done
endef

# rewrite libtool libraries automatically
REWRITE_LIBTOOL_LA = $(call rewrite_libtool,$(TARGET_LIB_DIR))

# -----------------------------------------------------------------------------

#
# rewrite pkg-config files
#
REWRITE_CONFIG_RULES = \
	sed -i \
	-e "s,^prefix=.*,prefix='$(TARGET_DIR)/usr'," \
	-e "s,^exec_prefix=.*,exec_prefix='$(TARGET_DIR)/usr'," \
	-e "s,^libdir=.*,libdir='$(TARGET_LIB_DIR)'," \
	-e "s,^includedir=.*,includedir='$(TARGET_INCLUDE_DIR)',"

REWRITE_CONFIG = \
	$(REWRITE_CONFIG_RULES)

# -----------------------------------------------------------------------------

#
# Manipulation of .config files based on the Kconfig infrastructure.
# Used by the BusyBox package, the Linux kernel package, and more.
#
define KCONFIG_ENABLE_OPT # (option, file)
	sed -i -e "/\\<$(1)\\>/d" $(2)
	echo '$(1)=y' >> $(2)
endef

define KCONFIG_SET_OPT # (option, value, file)
	sed -i -e "/\\<$(1)\\>/d" $(3)
	echo '$(1)=$(2)' >> $(3)
endef

define KCONFIG_DISABLE_OPT # (option, file)
	sed -i -e "/\\<$(1)\\>/d" $(2)
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

archives-list:
	@rm -f $(BUILD_DIR)/$(@)
	@make -qp | grep --only-matching '^\$(DL_DIR).*:' | sed "s|:||g" > $(BUILD_DIR)/$(@)

DOCLEANUP  ?= no
GETMISSING ?= no
archives-info: directories archives-list
	@grep --only-matching '^\$$(DL_DIR).*:' package/bootstrap.mk | sed "s|:||g" | \
	while read target; do \
		found=false; \
		for makefile in package/*/*/*.mk; do \
			if grep -q "$$target" $$makefile; then \
				found=true; \
			fi; \
			if [ "$$found" = "true" ]; then \
				continue; \
			fi; \
		done; \
		if [ "$$found" = "false" ]; then \
			echo -e "[$(TERM_RED) !! $(TERM_NORMAL)] $$target"; \
		fi; \
	done;
	@echo "[ ** ] Unused archives for this build system"
	@find $(DL_DIR)/ -maxdepth 1 -type f | \
	while read archive; do \
		if ! grep -q $$archive $(BUILD_DIR)/archives-list; then \
			echo -e "[$(TERM_YELLOW) rm $(TERM_NORMAL)] $$archive"; \
			if [ "$(DOCLEANUP)" = "yes" ]; then \
				rm $$archive; \
			fi; \
		fi; \
	done;
	@echo "[ ** ] Missing archives for this build system"
	@cat $(BUILD_DIR)/archives-list | \
	while read archive; do \
		if [ -e $$archive ]; then \
			#echo -e "[$(TERM_GREEN) ok $(TERM_NORMAL)] $$archive"; \
			true; \
		else \
			echo -e "[$(TERM_YELLOW) -- $(TERM_NORMAL)] $$archive"; \
			if [ "$(GETMISSING)" = "yes" ]; then \
				make $$archive; \
			fi; \
		fi; \
	done;
	@$(REMOVE)/archives-list

# -----------------------------------------------------------------------------

#
# FIXME - how to resolve variables while grepping makefiles?
#
patches-info:
	@echo "[ ** ] Unused patches"
	@for patch in package/*/*/patches/*; do \
		if [ ! -f $$patch ]; then \
			continue; \
		fi; \
		patch=$${patch##*/}; \
		found=false; \
		for makefile in package/*/*/*.mk; do \
			if grep -q "$$patch" $$makefile; then \
				found=true; \
			fi; \
			if [ "$$found" = "true" ]; then \
				continue; \
			fi; \
		done; \
		if [ "$$found" = "false" ]; then \
			echo -e "[$(TERM_RED) !! $(TERM_NORMAL)] $$patch"; \
		fi; \
	done;

# -----------------------------------------------------------------------------

#
# python helpers
#
HOST_PYTHON_BUILD = \
	CC="$(HOSTCC)" \
	CFLAGS="$(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)" \
	LDSHARED="$(HOSTCC) -shared" \
	PYTHONPATH=$(HOST_DIR)/$(HOST_PYTHON3_BASE_DIR)/site-packages \
	$(HOST_DIR)/bin/python3 ./setup.py $(SILENT_Q) build --executable=/usr/python

HOST_PYTHON_INSTALL = \
	CC="$(HOSTCC)" \
	CFLAGS="$(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)" \
	LDSHARED="$(HOSTCC) -shared" \
	PYTHONPATH=$(HOST_DIR)/$(HOST_PYTHON3_BASE_DIR)/site-packages \
	$(HOST_DIR)/bin/python3 ./setup.py $(SILENT_Q) install --root=$(HOST_DIR) --prefix=

PYTHON_BUILD = \
	CC="$(TARGET_CC)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	LDSHARED="$(TARGET_CC) -shared" \
	PYTHONPATH=$(TARGET_DIR)/$(PYTHON_BASE_DIR)/site-packages \
	CPPFLAGS="$(TARGET_CPPFLAGS) -I$(TARGET_DIR)/$(PYTHON_INCLUDE_DIR)" \
	$(HOST_DIR)/bin/python ./setup.py $(SILENT_Q) build --executable=/usr/bin/python

PYTHON_INSTALL = \
	CC="$(TARGET_CC)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	LDSHARED="$(TARGET_CC) -shared" \
	PYTHONPATH=$(TARGET_DIR)/$(PYTHON_BASE_DIR)/site-packages \
	CPPFLAGS="$(TARGET_CPPFLAGS) -I$(TARGET_DIR)/$(PYTHON_INCLUDE_DIR)" \
	$(HOST_DIR)/bin/python ./setup.py $(SILENT_Q) install --root=$(TARGET_DIR) --prefix=/usr

# -----------------------------------------------------------------------------

#
# target for testing only. not useful otherwise
#
everything:
	@make $(shell sed -n 's/^\$$.D.\/\(.*\):.*/\1/p' package/target/*/*.mk)

# -----------------------------------------------------------------------------

#
# print all present targets...
#
print-targets:
	@sed -n 's/^\$$.D.\/\(.*\):.*/\1/p; s/^\([a-z].*\):\( \|$$\).*/\1/p;' \
		`ls -1 package/*/*/*.mk` | \
		sort -u | fold -s -w 65

# -----------------------------------------------------------------------------

#
#
#
ifeq ($(GITSSH), 1)
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
		sed -i -e 's|url = $(URL_1)|url = $(URL_2)|' $$repo/.git/config; \
	done

# -----------------------------------------------------------------------------

#
#
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
#
#
neutrino-patch:
	@printf "$(TERM_YELLOW)---> create $(NEUTRINO) patch ... $(TERM_NORMAL)"
	$(shell cd $(SOURCE_DIR) && diff -Nur --exclude-from=$(HELPERS_DIR)/diff-exclude $(NEUTRINO_DIR).org $(NEUTRINO_DIR) > $(BUILD_DIR)/$(NEUTRINO)-$(DATE).patch)
	@printf "$(TERM_YELLOW)done\n$(TERM_NORMAL)"

libstb-hal-patch:
	@printf "$(TERM_YELLOW)---> create $(LIBSTB_HAL) patch ... $(TERM_NORMAL)"
	$(shell cd $(SOURCE_DIR) && diff -Nur --exclude-from=$(HELPERS_DIR)/diff-exclude $(LIBSTB_HAL_DIR).org $(LIBSTB_HAL_DIR) > $(BUILD_DIR)/$(LIBSTB_HAL)-$(DATE).patch)
	@printf "$(TERM_YELLOW)done\n$(TERM_NORMAL)"
