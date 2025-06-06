CAMLC=$(BINDIR)ocamlc
CAMLDEP=$(BINDIR)ocamldep
CAMLLEX=$(BINDIR)ocamllex
CAMLYACC=$(BINDIR)ocamlyacc
# COMPFLAGS=-w A-4-6-9 -warn-error A -g
COMPFLAGS=

EXEC = main

# Fichiers générés par ocamllex et ocamlyacc
GENERATED = lexer.ml parser.ml parser.mli

# Tous les fichiers .ml sauf les fichiers générés
CORE_SOURCES = $(filter-out $(GENERATED), $(wildcard *.ml))

MLIS =
# Ordre correct des objets selon les dépendances
OBJS = ast.cmo exception_content.cmo namespace.cmo subst.cmo mem.cmo parser.cmo lexer.cmo import.cmo main.cmo

# Building the world
all: $(EXEC)

$(EXEC): $(OBJS)
	$(CAMLC) $(COMPFLAGS) $(OBJS) -o $(EXEC)

.SUFFIXES:
.SUFFIXES: .ml .mli .cmo .cmi .cmx
.SUFFIXES: .mll .mly

.ml.cmo:
	$(CAMLC) $(COMPFLAGS) -c $<

.mli.cmi:
	$(CAMLC) $(COMPFLAGS) -c $<

.mll.ml:
	$(CAMLLEX) $<

.mly.ml:
	$(CAMLYACC) $<


# Clean up
clean:
	rm -f *.cm[io] *.cmx *~ .*~ *.o
	rm -f parser.mli
	rm -f $(GENERATED)
	rm -f $(EXEC)
	rm -f tarball-enonce.tgz tarball-solution.tgz

# Dependencies
depend: $(CORE_SOURCES) $(GENERATED) $(MLIS)
	$(CAMLDEP) $(CORE_SOURCES) $(GENERATED) $(MLIS) > .depend

include .depend

tarball-enonce:
	rm -f tarball-enonce.tgz
	tar cvzhf tarball-enonce.tgz \
		std.pdf Makefile fact.pcf ast.ml lexer.mll parser.mly

tarball-solution:
	rm -f tarball-solution.tgz
	tar cvzhf tarball-solution.tgz \
		ctd.pdf Makefile fact.pcf ast.ml lexer.mll parser.mly

