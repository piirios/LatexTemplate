type token =
  | EOF
  | INT of (
# 7 "parser.mly"
        int
# 7 "parser.mli"
)
  | FLOAT of (
# 8 "parser.mly"
        float
# 12 "parser.mli"
)
  | STRING of (
# 9 "parser.mly"
        string
# 17 "parser.mli"
)
  | IDENT of (
# 10 "parser.mly"
        string
# 22 "parser.mli"
)
  | IMPORT_PATH of (
# 11 "parser.mly"
        string
# 27 "parser.mli"
)
  | TEMPLATE_STRING of (
# 12 "parser.mly"
        string
# 32 "parser.mli"
)
  | EQUALEQUAL
  | COLONEQUAL
  | PLUS
  | MINUS
  | MULT
  | DIV
  | GREATER
  | SMALLER
  | GREATEREQUAL
  | SMALLEREQUAL
  | LPAREN
  | RPAREN
  | COMMA
  | LSIMPLEBRACE
  | RSIMPLEBRACE
  | LBRACKET
  | RBRACKET
  | SEMICOLON
  | DOUBLEDOT
  | UNIT
  | LET
  | MUT
  | RETURN
  | PRINT
  | FOR
  | WHILE
  | LOOP
  | IN
  | IF
  | ELSE
  | ELSIF
  | TRUE
  | FALSE
  | BREAK
  | FN
  | TEMPLATE
  | ENDIF
  | ENDLOOP
  | ENDFOR
  | ENDWHILE
  | USE
  | TEMPLATE_START
  | TEMPLATE_END
  | VAR_START
  | VAR_END

val componants :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.top_level list
