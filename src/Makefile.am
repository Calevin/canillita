## Process this file with automake to produce Makefile.in

## Created by Anjuta


uidir = $(pkgdatadir)/ui
ui_DATA = canillita.ui


AM_CPPFLAGS = \
	-DPACKAGE_LOCALE_DIR=\""$(localedir)"\" \
	-DPACKAGE_SRC_DIR=\""$(srcdir)"\" \
	-DPACKAGE_DATA_DIR=\""$(pkgdatadir)"\" \
	$(CANILLITA_CFLAGS)

AM_CFLAGS =\
	 -Wall\
	 -g

bin_PROGRAMS = canillita

canillita_SOURCES = \
	canillita.vala \
	canillita-resources.c \
	config.vapi \
	canillita-liststore-revistas.vala \
	canillita-revista.vala \
	canillita-revista-dao.vala \
	$(NULL)

canillita-resources.c: canillita.gresources.xml
	$(AM_V_GEN) $(GLIB_COMPILE_RESOURCES) $(srcdir)/canillita.gresources.xml \
	--target=$@ --sourcedir=$(srcdir) --c-name canillita --generate-source

canillita_VALAFLAGS =  --pkg sqlite3 --pkg glib-2.0 --pkg gtk+-3.0  \
	--pkg gtk+-3.0 --pkg salva --target-glib=2.38 --gresources canillita.gesources.xml

canillita_LDFLAGS =

canillita_LDADD = $(CANILLITA_LIBS)


if PLATFORM_WIN32
canillita_LDFLAGS += -Wl,--export-all-symbols
else
canillita_LDFLAGS += -Wl,--export-dynamic
endif

if NATIVE_WIN32
canillita_LDFLAGS += -mwindows
endif

CLEANFILES = \
	*.c

EXTRA_DIST = $(ui_DATA)

# Remove ui directory on uninstall
uninstall-local:
	-rm -r $(uidir)
	-rm -r $(pkgdatadir)

