################################################################################
#
# Make package infrastructure
#
################################################################################

TARGET_MAKE_ENV = \
	PATH=$(PATH)

TARGET_CONFIGURE_ENV = \
	$(TARGET_MAKE_ENV) \
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
	CPPFLAGS="$(TARGET_CPPFLAGS)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	CXXFLAGS="$(TARGET_CXXFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)" \
	PKG_CONFIG_PATH="$(TARGET_LIB_DIR)/pkgconfig" \
	PKG_CONFIG_SYSROOT_DIR="$(TARGET_DIR)" \
	$($(PKG)_CONF_ENV)

TARGET_CONFIGURE_OPTS = \
	--build=$(GNU_HOST_NAME) \
	--host=$(GNU_TARGET_NAME) \
	--target=$(GNU_TARGET_NAME) \
	--program-prefix= \
	--program-suffix= \
	--prefix=$(prefix) \
	--exec-prefix=$(exec_prefix) \
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

TARGET_CONFIGURE = \
	if [ "$($(PKG)_AUTORECONF)" == "YES" ]; then \
	  autoreconf -fi -I $(TARGET_SHARE_DIR)/aclocal; \
	fi; \
	test -f ./configure || ./autogen.sh && \
	CONFIG_SITE=/dev/null \
	$(TARGET_CONFIGURE_ENV) \
	./configure \
	$(TARGET_CONFIGURE_OPTS)

define make-package
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(call TARGET_FOLLOWUP)
endef

# -----------------------------------------------------------------------------

HOST_MAKE_ENV = \
	PATH=$(PATH) \
	PKG_CONFIG=/usr/bin/pkg-config \
	PKG_CONFIG_LIBDIR="$(HOST_DIR)/lib/pkgconfig"

HOST_CONFIGURE_ENV = \
	$(HOST_MAKE_ENV) \
	AR="$(HOSTAR)" \
	AS="$(HOSTAS)" \
	LD="$(HOSTLD)" \
	NM="$(HOSTNM)" \
	CC="$(HOSTCC)" \
	GCC="$(HOSTCC)" \
	CXX="$(HOSTCXX)" \
	CPP="$(HOSTCPP)" \
	OBJCOPY="$(HOSTOBJCOPY)" \
	RANLIB="$(HOSTRANLIB)" \
	CPPFLAGS="$(HOST_CPPFLAGS)" \
	CFLAGS="$(HOST_CFLAGS)" \
	CXXFLAGS="$(HOST_CXXFLAGS)" \
	LDFLAGS="$(HOST_LDFLAGS)" \
	$($(PKG)_CONF_ENV)

HOST_CONFIGURE_OPTS = \
	--prefix=$(HOST_DIR) \
	--sysconfdir=$(HOST_DIR)/etc \
	$($(PKG)_CONF_OPTS)

HOST_CONFIGURE = \
	if [ "$($(PKG)_AUTORECONF)" == "YES" ]; then \
	  autoreconf -fi; \
	fi; \
	test -f ./configure || ./autogen.sh && \
	CONFIG_SITE=/dev/null \
	$(HOST_CONFIGURE_ENV) \
	./configure \
	$(HOST_CONFIGURE_OPTS)

define host-make-package
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(HOST_CONFIGURE); \
		$(MAKE); \
		$(MAKE) install
	$(call HOST_FOLLOWUP)
endef
