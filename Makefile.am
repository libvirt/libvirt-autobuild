
confdir = $(sysconfdir)/auto-build.d
conf_DATA = conf/auto-build-libvirt.conf

EXTRA_DIST = $(PACKAGE).spec $(conf_DATA)

DISTCLEAN_FILES = $(PACKAGE).spec

dist-hook: gen-ChangeLog

# Generate the ChangeLog file (with all entries since the switch to git)
# and insert it into the directory we're about to use to create a tarball.
.PHONY: gen-ChangeLog
gen-ChangeLog:
	if test -d .git || test -d ../.git; then \
	  $(top_srcdir)/build-aux/gitlog-to-changelog \
	     > $(distdir)/cl-t; \
	  rm -f $(distdir)/ChangeLog; \
	  mv $(distdir)/cl-t $(distdir)/ChangeLog; \
	fi
