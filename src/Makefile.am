# Source Makefile.am
#
# Copyright (c) 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011 Free Software Foundation, Inc.
#
# This file is part of GNU Zile.
#
# GNU Zile is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# GNU Zile is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Zile; see the file COPYING.  If not, write to the
# Free Software Foundation, Fifth Floor, 51 Franklin Street, Boston,
# MA 02111-1301, USA.

LUA_ENV = LUA_INIT= LUA_PATH="$(srcdir)/src/?.lua;;"

bin_SCRIPTS = src/zile

BUILT_SOURCES = src/loadlua.lua

src_zile_LUA =						\
	src/lib.lua						\
	src/history.lua					\
	src/lisp.lua					\
	src/tbl_vars.lua					\
	src/variables.lua					\
	src/main.lua					\
	src/basic.lua					\
	src/bind.lua					\
	src/buffer.lua					\
	src/completion.lua					\
	src/editfns.lua					\
	src/funcs.lua					\
	src/getkey.lua					\
	src/help.lua					\
	src/file.lua					\
	src/keycode.lua					\
	src/killring.lua					\
	src/line.lua					\
	src/macro.lua					\
	src/marker.lua					\
	src/minibuf.lua					\
	src/point.lua					\
	src/redisplay.lua					\
	src/registers.lua					\
	src/search.lua					\
	src/undo.lua					\
	src/window.lua					\
	src/term_curses.lua					\
	src/term_minibuf.lua				\
	src/term_redisplay.lua

LUA_RUNTIME =						\
	src/ldb.lua						\
	src/ldb-config.lua					\
	$(src_zile_LUA)

dist_pkgdata_DATA +=					\
	$(LUA_RUNTIME)					\
	src/loadlua.lua					\
	src/default-bindings.el				\
	src/dotzile-extra.el

PRODUCTIONSOURCES =					\
	$(src_zile_LUA)					\
	src/ldb-config.lua					\
	src/Makefile.am Makefile.am configure.ac	\
	*.el

LUA_CLIBS = posix curses bit rex_gnu

src/loadlua.lua: Makefile.am
	echo "-- Generated file - do not edit!" > $@
	for i in $(LUA_CLIBS) $(LUA_RUNTIME); do echo 'require "'`echo $$i | sed -e 's|^src/||;s|\\.lua$$||'`'"' >> $@; done

install_edit = sed \
	-e 's|@pkgdatadir[@]|$(pkgdatadir)|g'

inplace_edit = sed \
	-e "s|@pkgdatadir[@]|`cd $(srcdir)/src && pwd`|g"

src/zile: src/zile.lua Makefile
	rm -f $@ $@.tmp
	$(inplace_edit) '$(builddir)/$@.lua' >$@.tmp
	mv $@.tmp $@
	chmod +x $@

install-exec-hook:
	$(install_edit) '$(builddir)/src/zile.lua' >$@.tmp
	$(INSTALL_SCRIPT) $@.tmp $(DESTDIR)$(bindir)/zile
	rm -f $@.tmp

src/zile.1: src/zile src/zile.1.in Makefile
	rm -f $@ $@.tmp
	$(install_edit) '$(srcdir)/$@.in' >$@.tmp
	mv $@.tmp $@

src/zile.1.in: src/main.lua src/man-extras src/zile-help2man-wrapper
	cd src && \
	builddir=$(builddir) $(HELP2MAN) --output=zile.1.in --no-info --name="Zile Is Lossy Emacs" --include $(srcdir)/man-extras $(srcdir)/zile-help2man-wrapper

dist_man_MANS = src/zile.1

CLEANFILES = src/zile
DISTCLEANFILES = src/zile.1
MAINTAINERCLEANFILES = src/loadlua.lua src/zile.1.in

TESTSOURCES = $(LISP_TESTS) $(LISP_TESTS_ZILE_ONLY) $(TESTSCRIPTS)
ALLSOURCES = $(TESTSOURCES) $(PRODUCTIONSOURCES)

CLOC = cloc --force-lang="C",h

loc:
	$(CLOC) $(PRODUCTIONSOURCES)

loc-tests:
	$(CLOC) $(TESTSOURCES)

loc-all:
	$(CLOC) $(ALLSOURCES)

TESTS_VARS = srcdir=$(srcdir)/src builddir=$(builddir)
TESTS_ENVIRONMENT = $(TESTS_VARS)

check-local:
	echo $(LISP_TESTS) | $(LUA_ENV) $(TESTS_VARS) EMACS="$(EMACS)" xargs $(LUA) "$(srcdir)/src/run-lisp-tests.lua"
	echo $(LISP_TESTS_ZILE_ONLY) | $(LUA_ENV) $(TESTS_VARS) EMACS= xargs $(LUA) "$(srcdir)/src/run-lisp-tests.lua"

TESTSCRIPTS =						\
	src/run-lisp-tests.lua				\
	src/test-bad-argument

# FIXME: Find a way of making these work
#	lisp-tests/disabled/*.el

# FIXME: Make these work in Emacs too
LISP_TESTS_ZILE_ONLY = $(srcdir)/src/lisp-tests/zile-only/*.el

LISP_TESTS = $(srcdir)/src/lisp-tests/*.el

LISP_TESTS_OUTPUTS = $(srcdir)/src/lisp-tests/*.output $(srcdir)/src/lisp-tests/zile-only/*.output

EXTRA_DIST +=						\
	$(LUA_RUNTIME)					\
	src/zile.lua.in					\
	$(LISP_TESTS)					\
	$(LISP_TESTS_ZILE_ONLY)				\
	$(LISP_TESTS_OUTPUTS)				\
	src/lisp-tests/test.input				\
	$(TESTSCRIPTS)					\
	src/quit.el						\
	src/man-extras					\
	src/zile.1.in					\
	src/zile-help2man-wrapper
