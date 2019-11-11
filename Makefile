PREFIX ?= /usr
MANDIR ?= $(PREFIX)/share/man

all:
	@echo Run \'make install\' to install serp.

manpage: serp.1

serp.1: serp
	@help2man --output=$@ --name='easily create (se)cure (r)edundant (p)ackages' -N ./serp

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(MANDIR)/man1
	@cp -p serp $(DESTDIR)$(PREFIX)/bin/serp
	@cp -p serp.1 $(DESTDIR)$(MANDIR)/man1
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/serp

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/serp
	@rm -rf $(DESTDIR)$(MANDIR)/man1/serp.1*

