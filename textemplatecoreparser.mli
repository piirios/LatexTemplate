type token =
  | EOF
  | INT of (
# 8 "textemplatecoreparser.mly"
        int
# 7 "textemplatecoreparser.mli"
)
  | FLOAT of (
# 9 "textemplatecoreparser.mly"
        float
# 12 "textemplatecoreparser.mli"
)
  | STRING of (
# 10 "textemplatecoreparser.mly"
        string
# 17 "textemplatecoreparser.mli"
)
  | IDENT of (
# 11 "textemplatecoreparser.mly"
        string
# 22 "textemplatecoreparser.mli"
)
  | TRUE
  | FALSE
  | UNIT
  | PLUS
  | MINUS
  | MULT
  | DIV
  | EQUALEQUAL
  | GREATER
  | SMALLER
  | GREATEREQUAL
  | SMALLEREQUAL
  | LPAREN
  | RPAREN
  | LSIMPLEBRACE
  | RSIMPLEBRACE
  | LBRACKET
  | RBRACKET
  | SEMICOLON
  | COMMA
  | DOUBLEDOT
  | RETURN
  | LET
  | PRINT
  | FOR
  | WHILE
  | LOOP
  | IF
  | ELSE
  | ELSIF

val expr :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Textemplatecoreast.expr
