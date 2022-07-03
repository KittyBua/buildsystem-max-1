################################################################################
#
# Autotools package infrastructure
#
################################################################################

define AUTORECONF_HOOK
	$(Q)( \
	if [ "$($(PKG)_AUTORECONF)" == "YES" ]; then \
		$(call MESSAGE,"Autoreconfiguring"); \
		$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
			$($(PKG)_AUTORECONF_ENV) \
			autoreconf -fi -I $(TARGET_SHARE_DIR)/aclocal \
				$($(PKG)_AUTORECONF_OPTS); \
	fi; \
	)
endef

# -----------------------------------------------------------------------------

TARGET_CONFIGURE_ENV = \
	$(TARGET_MAKE_ENV) \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	CC="$(TARGET_CC)" \
	GCC="$(TARGET_CC)" \
	CPP="$(TARGET_CPP)" \
	CXX="$(TARGET_CXX)" \
	LD="$(TARGET_LD)" \
	AR="$(TARGET_AR)" \
	AS="$(TARGET_AS)" \
	NM="$(TARGET_NM)" \
	OBJCOPY="$(TARGET_OBJCOPY)" \
	OBJDUMP="$(TARGET_OBJDUMP)" \
	RANLIB="$(TARGET_RANLIB)" \
	READELF="$(TARGET_READELF)" \
	STRIP="$(TARGET_STRIP)" \
	ARCH="$(TARGET_ARCH)" \
	AR_FOR_BUILD="$(HOSTAR)" \
	AS_FOR_BUILD="$(HOSTAS)" \
	CC_FOR_BUILD="$(HOSTCC)" \
	GCC_FOR_BUILD="$(HOSTCC)" \
	CXX_FOR_BUILD="$(HOSTCXX)" \
	LD_FOR_BUILD="$(HOSTLD)" \
	CPPFLAGS_FOR_BUILD="$(HOST_CPPFLAGS)" \
	CFLAGS_FOR_BUILD="$(HOST_CFLAGS)" \
	CXXFLAGS_FOR_BUILD="$(HOST_CXXFLAGS)" \
	LDFLAGS_FOR_BUILD="$(HOST_LDFLAGS)" \
	FCFLAGS_FOR_BUILD="$(HOST_FCFLAGS)" \
	DEFAULT_ASSEMBLER="$(TARGET_AS)" \
	DEFAULT_LINKER="$(TARGET_LD)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	CPPFLAGS="$(TARGET_CPPFLAGS)" \
	CXXFLAGS="$(TARGET_CXXFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)"

TARGET_CONFIGURE_ENV += \
	PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)" \
	PKG_CONFIG_PATH="$(TARGET_LIB_DIR)/pkgconfig" \
	PKG_CONFIG_SYSROOT_DIR="$(TARGET_DIR)"

TARGET_CONFIGURE_OPTS = \
	--build=$(GNU_HOST_NAME) \
	--host=$(GNU_TARGET_NAME) \
	--target=$(GNU_TARGET_NAME) \
	--program-prefix="" \
	--program-suffix="" \
	--prefix=$(prefix) \
	--exec-prefix=$(exec_prefix) \
	--bindir=$(bindir) \
	--datadir=$(datadir) \
	--includedir=$(includedir) \
	--libdir=$(libdir) \
	--libexecdir=$(libexecdir) \
	--oldincludedir=$(oldincludedir) \
	--sbindir=$(sbindir) \
	--sharedstatedir=$(sharedstatedir) \
	--sysconfdir=$(sysconfdir) \
	--localstatedir=$(localstatedir) \
	\
	--mandir=$(REMOVE_mandir) \
	--infodir=$(REMOVE_infodir)

define TARGET_CONFIGURE
	@$(call MESSAGE,"Configuring")
	$(foreach hook,$($(PKG)_PRE_CONFIGURE_HOOKS),$(call $(hook))$(sep))
	$(call AUTORECONF_HOOK)
	$(Q)( \
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
		test -f ./configure || ./autogen.sh && \
		CONFIG_SITE=/dev/null \
		$(TARGET_CONFIGURE_ENV) $($(PKG)_CONF_ENV) \
		./configure \
			$(TARGET_CONFIGURE_OPTS) $($(PKG)_CONF_OPTS); \
	)
	$(foreach hook,$($(PKG)_POST_CONFIGURE_HOOKS),$(call $(hook))$(sep))
endef

define autotools-package
	$(call PREPARE,$(1))
	$(call TARGET_CONFIGURE)
	$(if $(filter $(1),$(PKG_NO_BUILD)),,$(call TARGET_MAKE))
	$(if $(filter $(1),$(PKG_NO_INSTALL)),,$(call TARGET_MAKE_INSTALL))
	$(call TARGET_FOLLOWUP)
endef

################################################################################
#
# Host autotools package infrastructure
#
################################################################################

HOST_CONFIGURE_ENV = \
	$(HOST_MAKE_ENV) \
	CC="$(HOSTCC)" \
	GCC="$(HOSTCC)" \
	CPP="$(HOSTCPP)" \
	CXX="$(HOSTCXX)" \
	LD="$(HOSTLD)" \
	AR="$(HOSTAR)" \
	AS="$(HOSTAS)" \
	NM="$(HOSTNM)" \
	OBJCOPY="$(HOSTOBJCOPY)" \
	RANLIB="$(HOSTRANLIB)" \
	CFLAGS="$(HOST_CFLAGS)" \
	CPPFLAGS="$(HOST_CPPFLAGS)" \
	CXXFLAGS="$(HOST_CXXFLAGS)" \
	LDFLAGS="$(HOST_LDFLAGS)"

HOST_CONFIGURE_OPTS = \
	--prefix="$(HOST_DIR)" \
	--sysconfdir="$(HOST_DIR)/etc" \
	--localstatedir="$(HOST_DIR)/var" \
	--enable-shared \
	--disable-static \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-doc \
	--disable-docs \
	--disable-documentation \
	--disable-debug \
	--with-xmlto=no \
	--with-fop=no \
	--disable-nls

define HOST_CONFIGURE
	@$(call MESSAGE,"Configuring")
	$(foreach hook,$($(PKG)_PRE_CONFIGURE_HOOKS),$(call $(hook))$(sep))
	$(call AUTORECONF_HOOK)
	$(Q)( \
	$(CHDIR)/$($(PKG)_DIR)/$($(PKG)_SUBDIR); \
		test -f ./configure || ./autogen.sh && \
		CONFIG_SITE=/dev/null \
		$(HOST_CONFIGURE_ENV) $($(PKG)_CONF_ENV) \
		./configure \
			$(HOST_CONFIGURE_OPTS) $($(PKG)_CONF_OPTS); \
	)
	$(foreach hook,$($(PKG)_POST_CONFIGURE_HOOKS),$(call $(hook))$(sep))
endef

define host-autotools-package
	$(call PREPARE,$(1))
	$(call HOST_CONFIGURE)
	$(if $(filter $(1),$(PKG_NO_BUILD)),,$(call HOST_MAKE))
	$(if $(filter $(1),$(PKG_NO_INSTALL)),,$(call HOST_MAKE_INSTALL))
	$(call HOST_FOLLOWUP)
endef