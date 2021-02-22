#
# ncurses
#
NCURSES_VER    = 6.1
NCURSES_DIR    = ncurses-$(NCURSES_VER)
NCURSES_SOURCE = ncurses-$(NCURSES_VER).tar.gz
NCURSES_SITE   = https://ftp.gnu.org/pub/gnu/ncurses
NCURSES_DEPS   = bootstrap

NCURSES_PATCH = \
	$(addprefix https://invisible-mirror.net/archives/ncurses/$(NCURSES_VER)/, \
		ncurses-6.1-20190609-patch.sh.bz2 \
		ncurses-6.1-20190615.patch.gz \
		ncurses-6.1-20190623.patch.gz \
		ncurses-6.1-20190630.patch.gz \
		ncurses-6.1-20190706.patch.gz \
		ncurses-6.1-20190713.patch.gz \
		ncurses-6.1-20190720.patch.gz \
		ncurses-6.1-20190727.patch.gz \
		ncurses-6.1-20190728.patch.gz \
		ncurses-6.1-20190803.patch.gz \
		ncurses-6.1-20190810.patch.gz \
		ncurses-6.1-20190817.patch.gz \
		ncurses-6.1-20190824.patch.gz \
		ncurses-6.1-20190831.patch.gz \
		ncurses-6.1-20190907.patch.gz \
		ncurses-6.1-20190914.patch.gz \
		ncurses-6.1-20190921.patch.gz \
		ncurses-6.1-20190928.patch.gz \
		ncurses-6.1-20191005.patch.gz \
		ncurses-6.1-20191012.patch.gz \
		ncurses-6.1-20191015.patch.gz \
		ncurses-6.1-20191019.patch.gz \
		ncurses-6.1-20191026.patch.gz \
		ncurses-6.1-20191102.patch.gz \
		ncurses-6.1-20191109.patch.gz \
		ncurses-6.1-20191116.patch.gz \
		ncurses-6.1-20191123.patch.gz \
		ncurses-6.1-20191130.patch.gz \
		ncurses-6.1-20191207.patch.gz \
		ncurses-6.1-20191214.patch.gz \
		ncurses-6.1-20191221.patch.gz \
		ncurses-6.1-20191228.patch.gz \
		ncurses-6.1-20200104.patch.gz \
		ncurses-6.1-20200111.patch.gz \
		ncurses-6.1-20200118.patch.gz \
	)

NCURSES_CONF_OPTS = \
	--enable-pc-files \
	--with-pkg-config \
	--with-pkg-config-libdir="/usr/lib/pkgconfig" \
	--with-normal \
	--with-shared \
	--with-fallbacks='linux vt100 xterm' \
	--without-ada \
	--without-cxx \
	--without-cxx-binding \
	--without-debug \
	--without-gpm \
	--without-manpages \
	--without-profile \
	--without-progs \
	--without-tests \
	--disable-big-core \
	--disable-rpath \
	--disable-rpath-hack \
	--enable-const \
	--enable-widec \
	--enable-overwrite

NCURSES_CONFIG_SCRIPTS = ncurses$(NCURSES_LIB_SUFFIX)6-config
NCURSES_LIB_SUFFIX = w
NCURSES_LIBS = ncurses menu panel form

define NCURSES_LINK_LIBS_STATIC
	$(foreach lib,$(NCURSES_LIBS:%=lib%), \
		ln -sf $(lib)$(NCURSES_LIB_SUFFIX).a $(TARGET_DIR)/usr/lib/$(lib).a
	)
	ln -sf libncurses$(NCURSES_LIB_SUFFIX).a \
		$(TARGET_DIR)/usr/lib/libcurses.a
endef

define NCURSES_LINK_LIBS_SHARED
	$(foreach lib,$(NCURSES_LIBS:%=lib%), \
		ln -sf $(lib)$(NCURSES_LIB_SUFFIX).so $(TARGET_DIR)/usr/lib/$(lib).so
	)
	ln -sf libncurses$(NCURSES_LIB_SUFFIX).so \
		$(TARGET_DIR)/usr/lib/libcurses.so
endef

define NCURSES_LINK_PC
	$(foreach pc,$(NCURSES_LIBS), \
		ln -sf $(pc)$(NCURSES_LIB_SUFFIX).pc \
			$(TARGET_DIR)/usr/lib/pkgconfig/$(pc).pc
	)
endef

$(D)/ncurses:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE) libs; \
		$(MAKE) install.libs DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/bin/$(NCURSES_CONFIG_SCRIPTS) $(HOST_DIR)/bin
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/$(NCURSES_CONFIG_SCRIPTS)
	$(NCURSES_LINK_LIBS_STATIC)
	$(NCURSES_LINK_LIBS_SHARED)
	$(NCURSES_LINK_PC)
	$(REMOVE)
	$(TOUCH)
