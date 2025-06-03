OCAMLC = ocamlc
OCAMLYACC = ocamlyacc
OCAMLLEX = ocamllex

SOURCES = ast.ml templateparser.ml templatelexer.ml main.ml
OBJECTS = $(SOURCES:.ml=.cmo)
TARGET = template_parser

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(OCAMLC) -o $(TARGET) $(OBJECTS)

templateparser.ml templateparser.mli: templateparser.mly
	$(OCAMLYACC) templateparser.mly

templatelexer.ml: templatelexer.mll
	$(OCAMLLEX) templatelexer.mll

%.cmo: %.ml
	$(OCAMLC) -c $<

%.cmi: %.mli
	$(OCAMLC) -c $<

templateparser.cmo: templateparser.cmi ast.cmo
templatelexer.cmo: templateparser.cmi
main.cmo: templateparser.cmi templatelexer.cmo

clean:
	rm -f *.cmo *.cmi templateparser.ml templateparser.mli templatelexer.ml $(TARGET)

test: $(TARGET)
	./$(TARGET) ../exemple/template_test.templatetemplate

.PHONY: all clean test 