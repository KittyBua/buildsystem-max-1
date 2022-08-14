################################################################################
#
# This file contains various utility macros and variables used about
# everywhere in make constructs.
#
################################################################################

# Strip quotes and then whitespaces
qstrip = $(strip $(subst ",,$(1)))
#"))

# Variables for use in Make constructs
comma := ,
empty :=
space := $(empty) $(empty)
tab := $(empty)	$(empty)
escape := $(shell printf '\x1b')

# make 4.3:
# https://lwn.net/Articles/810071/
# Number signs (#) appearing inside a macro reference or function invocation
#   no longer introduce comments and should not be escaped with backslashes:
#   thus a call such as:
#     foo := $(shell echo '#')
#   is legal.  Previously the number sign needed to be escaped, for example:
#     foo := $(shell echo '\#')
#   Now this latter will resolve to "\#".  If you want to write makefiles
#   portable to both versions, assign the number sign to a variable:
#     H := \#
#     foo := $(shell echo '$H')
SHARP_SIGN := \#

# Case conversion macros. This is inspired by the 'up' macro from gmsl
# (http://gmsl.sf.net). It is optimised very heavily because these macros
# are used a lot. It is about 5 times faster than forking a shell and tr.
#
# The caseconvert-helper creates a definition of the case conversion macro.
# After expansion by the outer $(eval ), the UPPERCASE macro is defined as:
# $(strip $(eval __tmp := $(1))  $(eval __tmp := $(subst a,A,$(__tmp))) ... )
# In other words, every letter is substituted one by one.
#
# The caseconvert-helper allows us to create this definition out of the
# [FROM] and [TO] lists, so we don't need to write down every substition
# manually. The uses of $ and $$ quoting are chosen in order to do as
# much expansion as possible up-front.
#
# Note that it would be possible to conceive a slightly more optimal
# implementation that avoids the use of __tmp, but that would be even
# more unreadable and is not worth the effort.

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

# Reverse the orders of words in a list. Again, inspired by the gmsl
# 'reverse' macro.
reverse = $(if $(1),$(call reverse,$(wordlist 2,$(words $(1)),$(1))) $(firstword $(1)))

# Sanitize macro cleans up generic strings so it can be used as a filename
# and in rules. Particularly useful for VCS version strings, that can contain
# slashes, colons (OK in filenames but not in rules), and spaces.
sanitize = $(subst $(space),_,$(subst :,_,$(subst /,_,$(strip $(1)))))

TERM_RED         = \033[40;0;31m
TERM_RED_BOLD    = \033[40;1;31m
TERM_GREEN       = \033[40;0;32m
TERM_GREEN_BOLD  = \033[40;1;32m
TERM_YELLOW      = \033[40;0;33m
TERM_YELLOW_BOLD = \033[40;1;33m
TERM_NORMAL      = \033[0m

TERM_BOLD := $(shell tput smso 2>/dev/null)
TERM_RESET := $(shell tput rmso 2>/dev/null)

# MESSAGE Macro -- display a message in bold type
MESSAGE = echo -e "$(TERM_BOLD)>>> $(pkgname) $($(PKG)_VERSION) $(call qstrip,$(1))$(TERM_RESET)$(call qstrip,$(2))"
SUCCESS = echo -e "$(TERM_GREEN)$(call qstrip,$(1))$(TERM_NORMAL)$(call qstrip,$(2))"
WARNING = echo -e "$(TERM_RED_BOLD)$(call qstrip,$(1))$(TERM_NORMAL)$(call qstrip,$(2))"

# Utility functions for 'find'
# findfileclauses(filelist) => -name 'X' -o -name 'Y'
findfileclauses = $(call notfirstword,$(patsubst %,-o -name '%',$(1)))
# finddirclauses(base, dirlist) => -path 'base/dirX' -o -path 'base/dirY'
finddirclauses = $(call notfirstword,$(patsubst %,-o -path '$(1)/%',$(2)))

# Miscellaneous utility functions
# notfirstword(wordlist): returns all but the first word in wordlist
notfirstword = $(wordlist 2,$(words $(1)),$(1))

# build a comma-separated list of items, from a space-separated
# list of items:   a b c d  -->  a, b, c, d
make-comma-list = $(subst $(space),$(comma)$(space),$(strip $(1)))

# build a comma-separated list of double-quoted items, from a space-separated
# list of unquoted items:   a b c d  -->  "a", "b", "c", "d"
make-dq-comma-list = $(call make-comma-list,$(patsubst %,"%",$(strip $(1))))

# build a comma-separated list of single-quoted items, from a space-separated
# list of unquoted items:   a b c d  -->  'a', 'b', 'c', 'd'
make-sq-comma-list = $(call make-comma-list,$(patsubst %,'%',$(strip $(1))))

# Needed for the foreach loops to loop over the list of hooks, so that
# each hook call is properly separated by a newline.
define sep


endef

PERCENT = %
QUOTE = '
# ' # Meh... syntax-highlighting

# This macro properly escapes a command string, then prints it with printf:
#
#   - first, backslash '\' are self-escaped, so that they do not escape
#     the following char and so that printf properly outputs a backslash;
#
#   - next, single quotes are escaped by closing an existing one, adding
#     an escaped one, and re-openning a new one (see below for the reason);
#
#   - then '%' signs are self-escaped so that the printf does not interpret
#     them as a format specifier, in case the variable contains an actual
#     printf with a format;
#
#   - finally, $(sep) is replaced with the literal '\n' so that make does
#     not break on the so-expanded variable, but so that the printf does
#     correctly output an LF.
#
# Note: this must be escaped in this order to avoid over-escaping the
# previously escaped elements.
#
# Once everything has been escaped, it is passed between single quotes
# (that's why the single-quotes are escaped they way they are, above,
# and why the dollar sign is not escaped) to printf(1). A trailing
# newline is apended, too.
#
# Note: leading or trailing spaces are *not* stripped.
#
define PRINTF
	printf '$(subst $(sep),\n,\
		$(subst $(PERCENT),$(PERCENT)$(PERCENT),\
			$(subst $(QUOTE),$(QUOTE)\$(QUOTE)$(QUOTE),\
				$(subst \,\\,$(1)))))\n'
endef

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
	@ \
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
