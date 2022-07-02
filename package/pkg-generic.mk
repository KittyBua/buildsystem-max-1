################################################################################
#
# Generic package infrastructure
#
################################################################################

# start-up build
define STARTUP
	$(call DEPENDS)
	@$(call MESSAGE,"Start-up build")
	$(call CLEANUP)
endef

# -----------------------------------------------------------------------------

# resolve dependencies
define DEPENDS
	@make $($(PKG)_DEPENDS)
endef

# -----------------------------------------------------------------------------

# clean-up
define CLEANUP
	$(Q)( \
	if [ -d $(PKG_BUILD_DIR) ]; then \
		$(call MESSAGE,"Clean-up"); \
		cd $(BUILD_DIR) && rm -rf $($(PKG)_DIR); \
	fi; \
	)
endef

# -----------------------------------------------------------------------------

#
define TOUCH
	@$(call MESSAGE,"Building completed")
	@touch $@
	@echo ""
endef

# -----------------------------------------------------------------------------

# download archives into download directory
WGET_DOWNLOAD = wget --no-check-certificate -q --show-progress --progress=bar:force -t3 -T60 -c -P

# github(user,package,version): returns site of GitHub repository
github = https://github.com/$(1)/$(2)/archive/$(3)

GET_GIT_SOURCE = support/scripts/get-git-source.sh
GET_HG_SOURCE  = support/scripts/get-hg-source.sh
GET_SVN_SOURCE = support/scripts/get-svn-source.sh

define DOWNLOAD
	$(foreach hook,$($(PKG)_PRE_DOWNLOAD_HOOKS),$(call $(hook))$(sep))
	$(Q)( \
	if [ "$($(PKG)_VERSION)" == "git" ]; then \
	  $(call MESSAGE,"Downloading") ; \
	  $(GET_GIT_SOURCE) $($(PKG)_SITE)/$($(PKG)_SOURCE) $(DL_DIR)/$($(PKG)_SOURCE); \
	elif [ "$($(PKG)_VERSION)" == "hg" ]; then \
	  $(call MESSAGE,"Downloading") ; \
	  $(GET_HG_SOURCE) $($(PKG)_SITE)/$($(PKG)_SOURCE) $(DL_DIR)/$($(PKG)_SOURCE); \
	elif [ "$($(PKG)_VERSION)" == "svn" ]; then \
	  $(call MESSAGE,"Downloading") ; \
	  $(GET_SVN_SOURCE) $($(PKG)_SITE)/$($(PKG)_SOURCE) $(DL_DIR)/$($(PKG)_SOURCE); \
	elif [ ! -f $(DL_DIR)/$($(PKG)_SOURCE) ]; then \
	  $(call MESSAGE,"Downloading") ; \
	  $(WGET_DOWNLOAD) $(DL_DIR) $($(PKG)_SITE)/$(1); \
	fi; \
	)
	$(foreach hook,$($(PKG)_POST_DOWNLOAD_HOOKS),$(call $(hook))$(sep))
endef

# -----------------------------------------------------------------------------

# unpack archives into given directory
define EXTRACT
	@$(call MESSAGE,"Extracting")
	$(foreach hook,$($(PKG)_PRE_EXTRACT_HOOKS),$(call $(hook))$(sep))
	$(Q)( \
	case $($(PKG)_SOURCE) in \
	  *.tar | *.tar.bz2 | *.tbz | *.tar.gz | *.tgz | *.tar.xz | *.txz) \
	    tar -xf ${DL_DIR}/$($(PKG)_SOURCE) -C $(1); \
	    ;; \
	  *.zip) \
	    unzip -o -q ${DL_DIR}/$($(PKG)_SOURCE) -d $(1); \
	    ;; \
	  *.git) \
	    cp -a -t $(1) $(DL_DIR)/$($(PKG)_SOURCE); \
	    if test $($(PKG)_CHECKOUT); then \
	      $(call MESSAGE,"git checkout $($(PKG)_CHECKOUT)"); \
	      $(CD) $(1)/$($(PKG)_DIR); git checkout -q $($(PKG)_CHECKOUT); \
	    fi; \
	    ;; \
	  *.hg | hg.*) \
	    cp -a -t $(1) $(DL_DIR)/$($(PKG)_SOURCE); \
	    if test $($(PKG)_CHECKOUT); then \
	      $(call MESSAGE,"hg checkout $($(PKG)_CHECKOUT)"); \
	      $(CD) $(1)/$($(PKG)_DIR); hg checkout $($(PKG)_CHECKOUT); \
	    fi; \
	    ;; \
	  *.svn | svn.*) \
	    cp -a -t $(1) $(DL_DIR)/$($(PKG)_SOURCE); \
	    if test $($(PKG)_CHECKOUT); then \
	      $(call MESSAGE,"svn checkout $($(PKG)_CHECKOUT)"); \
	      $(CD) $(1)/$($(PKG)_DIR); svn checkout $($(PKG)_CHECKOUT); \
	    fi; \
	    ;; \
	  *) \
	    $(call MESSAGE,"Cannot extract $($(PKG)_SOURCE)"); \
	    false ;; \
	esac \
	)
	$(foreach hook,$($(PKG)_POST_EXTRACT_HOOKS),$(call $(hook))$(sep))
endef

# -----------------------------------------------------------------------------

# apply single patches or patch sets
PATCHES = \
	*.patch \
	*.patch-$(TARGET_CPU) \
	*.patch-$(TARGET_ARCH) \
	*.patch-$(BOXTYPE) \
	*.patch-$(BOXMODEL) \
	*.patch-$(FLAVOUR)

# for SOURCE_DIR
define APPLY_PATCHES_S
	@$(call MESSAGE,"Patching")
	$(foreach hook,$($(PKG)_PRE_PATCH_HOOKS),$(call $(hook))$(sep))
	$(Q)( \
	$(CD) $(SOURCE_DIR)/$($(PKG)_DIR); \
	for i in $(1) $(2); do \
	  if [ "$$i" == "$(PKG_PATCHES_DIR)" -a ! -d $$i ]; then \
	    continue; \
	  fi; \
	  if [ -d $$i ]; then \
	    for p in $(addprefix $$i/,$(PATCHES)); do \
	      if [ -e $$p ]; then \
	        echo -e "$(TERM_YELLOW)Applying$(TERM_NORMAL) $${p##*/}"; \
	        patch -p1 -i $$p; \
	      fi; \
	    done; \
	  else \
	    if [ $${i:0:1} == "/" ]; then \
	      echo -e "$(TERM_YELLOW)Applying$(TERM_NORMAL) $${i##*/}"; \
	      patch -p1 -i $$i; \
	    else \
	      echo -e "$(TERM_YELLOW)Applying$(TERM_NORMAL) $${i##*//}"; \
	      patch -p1 -i $(PKG_PATCHES_DIR)/$$i; \
	    fi; \
	  fi; \
	done; \
	)
	$(foreach hook,$($(PKG)_POST_PATCH_HOOKS),$(call $(hook))$(sep))
endef

# for BUILD_DIR
define APPLY_PATCHES
	@$(call MESSAGE,"Patching")
	$(foreach hook,$($(PKG)_PRE_PATCH_HOOKS),$(call $(hook))$(sep))
	$(Q)( \
	$(CD) $(BUILD_DIR)/$($(PKG)_DIR); \
	for i in $(1) $(2); do \
	  if [ "$$i" == "$(PKG_PATCHES_DIR)" -a ! -d $$i ]; then \
	    continue; \
	  fi; \
	  if [ -d $$i ]; then \
	    if [ -d $$i/$($(PKG)_VERSION) ]; then \
	      for p in $(addprefix $$i/,$($(PKG)_VERSION)/$(PATCHES)); do \
	        if [ -e $$p ]; then \
	          echo -e "$(TERM_YELLOW)Applying$(TERM_NORMAL) $${p##*/}"; \
	          patch -p1 -i $$p; \
	        fi; \
	      done; \
	    else \
	      for p in $(addprefix $$i/,$(PATCHES)); do \
	        if [ -e $$p ]; then \
	          echo -e "$(TERM_YELLOW)Applying$(TERM_NORMAL) $${p##*/}"; \
	          patch -p1 -i $$p; \
	        fi; \
	      done; \
	    fi; \
	  else \
	    if [ $${i:0:1} == "/" ]; then \
	      echo -e "$(TERM_YELLOW)Applying$(TERM_NORMAL) $${i##*/}"; \
	      patch -p1 -i $$i; \
	    else \
	      echo -e "$(TERM_YELLOW)Applying$(TERM_NORMAL) $${i##*/}"; \
	      patch -p1 -i $(PKG_PATCHES_DIR)/$$i; \
	    fi; \
	  fi; \
	done; \
	)
	$(foreach hook,$($(PKG)_POST_PATCH_HOOKS),$(call $(hook))$(sep))
endef

# -----------------------------------------------------------------------------
# ----------------------------------------------------------------------------

# prepare for build
define PREPARE
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(call APPLY_PATCHES,$(PKG_PATCHES_DIR),$($(PKG)_PATCH))
endef

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

# rewrite pkg-config files
REWRITE_CONFIG_RULES = \
	"s,^prefix=.*,prefix='$(TARGET_DIR)/usr',; \
	 s,^exec_prefix=.*,exec_prefix='$(TARGET_DIR)/usr',; \
	 s,^libdir=.*,libdir='$(TARGET_LIB_DIR)',; \
	 s,^includedir=.*,includedir='$(TARGET_INCLUDE_DIR)',"

define rewrite_config_script
	$(Q)( \
	mv $(TARGET_DIR)/$(bindir)/$(1) $(HOST_DIR)/bin; \
	$(call MESSAGE,"Rewriting $(1)"); \
	$(SED) $(REWRITE_CONFIG_RULES) $(HOST_DIR)/bin/$(1); \
	)
endef

# rewrite config scripts automatically
define REWRITE_CONFIG_SCRIPTS
	$(foreach config_script,$($(PKG)_CONFIG_SCRIPTS),\
		$(call rewrite_config_script,$(config_script))$(sep))
endef

# -----------------------------------------------------------------------------

# rewrite libtool libraries
REWRITE_LIBTOOL_RULES = \
	"s,^libdir=.*,libdir='$(1)',; \
	 s,\(^dependency_libs='\| \|-L\|^dependency_libs='\)/usr/lib,\ $(1),g"

REWRITE_LIBTOOL_TAG = rewritten=1

define rewrite_libtool
	@$(call MESSAGE,"Fixing libtool files")
	$(Q)( \
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
REWRITE_LIBTOOL = $(call rewrite_libtool,$(TARGET_LIB_DIR))

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

# follow-up build
define TARGET_FOLLOWUP
	@$(call MESSAGE,"Follow-up build")
	$(foreach hook,$($(PKG)_PRE_FOLLOWUP_HOOKS),$(call $(hook))$(sep))
	$(if $(BS_INIT_SYSTEMD),\
		$($(PKG)_INSTALL_INIT_SYSTEMD))
	$(if $(BS_INIT_SYSV),\
		$($(PKG)_INSTALL_INIT_SYSV))
	$(foreach hook,$($(PKG)_POST_FOLLOWUP_HOOKS),$(call $(hook))$(sep))
	$(call REWRITE_CONFIG_SCRIPTS)
	$(REWRITE_LIBTOOL)
	$(call CLEANUP)
	$(foreach hook,$($(PKG)_CLEANUP_TARGET_HOOKS),$(call $(hook))$(sep))
	$(TOUCH)
endef

define HOST_FOLLOWUP
	@$(call MESSAGE,"Follow-up build")
	$(foreach hook,$($(PKG)_PRE_FOLLOWUP_HOOKS),$(call $(hook))$(sep))
	$(foreach hook,$($(PKG)_POST_FOLLOWUP_HOOKS),$(call $(hook))$(sep))
	$(call CLEANUP)
	$(foreach hook,$($(PKG)_CLEANUP_HOOKS),$(call $(hook))$(sep))
	$(TOUCH)
endef

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
