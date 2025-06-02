CAMLC=$(BINDIR)ocamlc
CAMLDEP=$(BINDIR)ocamldep
CAMLLEX=$(BINDIR)ocamllex
CAMLYACC=$(BINDIR)ocamlyacc
# COMPFLAGS=-w A-4-6-9 -warn-error A -g
COMPFLAGS=

EXEC = main

# Fichiers compilés, à produire pour fabriquer l'exécutable
CORE_SOURCES = core/ast.ml main.ml
GENERATED = core/lexer.ml core/parser.ml core/parser.mli
MLIS =
OBJS = $(GENERATED:.ml=.cmo) $(CORE_SOURCES:.ml=.cmo)

# Building the world
all: $(EXEC)

$(EXEC): $(OBJS)
	$(CAMLC) $(COMPFLAGS) -I core $(OBJS) -o $(EXEC)

.SUFFIXES:
.SUFFIXES: .ml .mli .cmo .cmi .cmx
.SUFFIXES: .mll .mly

.ml.cmo:
	$(CAMLC) $(COMPFLAGS) -I core -c $<

.mli.cmi:
	$(CAMLC) $(COMPFLAGS) -I core -c $<

.mll.ml:
	$(CAMLLEX) $<

.mly.ml:
	$(CAMLYACC) $<


# Clean up
clean:
	rm -f core/*.cm[io] core/*.cmx core/*~ core/.*~ core/*.o
	rm -f core/parser.mli
	rm -f $(GENERATED)
	rm -f $(EXEC)
	rm -f tarball-enonce.tgz tarball-solution.tgz

# Dependencies
depend: $(CORE_SOURCES) $(GENERATED) $(MLIS)
	$(CAMLDEP) -I core $(CORE_SOURCES) $(GENERATED) $(MLIS) > .depend

include .depend

tarball-enonce:
	rm -f tarball-enonce.tgz
	tar cvzhf tarball-enonce.tgz \
		std.pdf Makefile fact.pcf core/ast.ml core/lexer.mll core/loop.ml core/parser-eleves.mly

tarball-solution:
	rm -f tarball-solution.tgz
	tar cvzhf tarball-solution.tgz \
		ctd.pdf Makefile fact.pcf core/ast.ml core/lexer.mll core/loop.ml core/parser.mly

