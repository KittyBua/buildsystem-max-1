#
# readline
#
READLINE_VER    = 6.2
READLINE_DIR    = readline-$(READLINE_VER)
READLINE_SOURCE = readline-$(READLINE_VER).tar.gz
READLINE_SITE   = https://ftp.gnu.org/gnu/readline

READLINE_CONF_OPTS = \
	--datadir=$(REMOVE_datarootdir) \
	bash_cv_must_reinstall_sighandlers=no \
	bash_cv_func_sigsetjmp=present \
	bash_cv_func_strcoll_broken=no \
	bash_cv_have_mbstate_t=yes

$(D)/readline: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
