type token =
  | EOF
  | INT of (
# 8 "textemplatecoreparser.mly"
        int
# 7 "textemplatecoreparser.ml"
)
  | FLOAT of (
# 9 "textemplatecoreparser.mly"
        float
# 12 "textemplatecoreparser.ml"
)
  | STRING of (
# 10 "textemplatecoreparser.mly"
        string
# 17 "textemplatecoreparser.ml"
)
  | IDENT of (
# 11 "textemplatecoreparser.mly"
        string
# 22 "textemplatecoreparser.ml"
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

open Parsing
let _ = parse_error;;
# 2 "textemplatecoreparser.mly"
    open Textemplatecoreast ;;
# 59 "textemplatecoreparser.ml"
let yytransl_const = [|
    0 (* EOF *);
  261 (* TRUE *);
  262 (* FALSE *);
  263 (* UNIT *);
  264 (* PLUS *);
  265 (* MINUS *);
  266 (* MULT *);
  267 (* DIV *);
  268 (* EQUALEQUAL *);
  269 (* GREATER *);
  270 (* SMALLER *);
  271 (* GREATEREQUAL *);
  272 (* SMALLEREQUAL *);
  273 (* LPAREN *);
  274 (* RPAREN *);
  275 (* LSIMPLEBRACE *);
  276 (* RSIMPLEBRACE *);
  277 (* LBRACKET *);
  278 (* RBRACKET *);
  279 (* SEMICOLON *);
  280 (* COMMA *);
  281 (* DOUBLEDOT *);
  282 (* RETURN *);
  283 (* LET *);
  284 (* PRINT *);
  285 (* FOR *);
  286 (* WHILE *);
  287 (* LOOP *);
  288 (* IF *);
  289 (* ELSE *);
  290 (* ELSIF *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* FLOAT *);
  259 (* STRING *);
  260 (* IDENT *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\002\000\002\000\
\004\000\004\000\003\000\003\000\003\000\003\000\003\000\003\000\
\000\000"

let yylen = "\002\000\
\004\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\002\000\003\000\001\000\004\000\000\000\002\000\
\000\000\003\000\001\000\001\000\001\000\001\000\001\000\001\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\020\000\023\000\000\000\021\000\022\000\019\000\
\000\000\000\000\000\000\013\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\012\000\000\000\000\000\009\000\
\010\000\000\000\000\000\000\000\000\000\000\000\000\000\016\000\
\001\000\014\000\000\000\018\000"

let yydgoto = "\002\000\
\011\000\027\000\012\000\040\000"

let yysindex = "\255\255\
\050\255\000\000\000\000\000\000\252\254\000\000\000\000\000\000\
\050\255\050\255\250\254\000\000\050\255\050\255\022\255\084\255\
\050\255\050\255\050\255\050\255\050\255\050\255\050\255\050\255\
\050\255\034\255\016\255\060\255\000\000\022\255\022\255\000\000\
\000\000\020\255\020\255\020\255\020\255\020\255\050\255\000\000\
\000\000\000\000\034\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\
\000\000\000\000\014\000\000\000\018\255\000\000\018\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\019\255\000\000\000\000\000\000\035\000\052\000\000\000\
\000\000\065\000\078\000\091\000\104\000\117\000\000\000\000\000\
\000\000\000\000\019\255\000\000"

let yygindex = "\000\000\
\002\000\000\000\000\000\251\255"

let yytablesize = 397
let yytable = "\001\000\
\024\000\017\000\018\000\019\000\020\000\021\000\022\000\023\000\
\024\000\025\000\015\000\016\000\013\000\025\000\026\000\028\000\
\014\000\011\000\030\000\031\000\032\000\033\000\034\000\035\000\
\036\000\037\000\038\000\017\000\018\000\019\000\020\000\019\000\
\020\000\041\000\007\000\015\000\017\000\044\000\000\000\000\000\
\043\000\017\000\018\000\019\000\020\000\021\000\022\000\023\000\
\024\000\025\000\003\000\008\000\004\000\005\000\006\000\007\000\
\008\000\039\000\009\000\000\000\000\000\000\000\000\000\000\000\
\002\000\000\000\010\000\017\000\018\000\019\000\020\000\021\000\
\022\000\023\000\024\000\025\000\000\000\003\000\000\000\000\000\
\000\000\042\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\005\000\017\000\018\000\019\000\020\000\021\000\
\022\000\023\000\024\000\025\000\000\000\029\000\000\000\004\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\006\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\024\000\024\000\024\000\024\000\024\000\024\000\024\000\024\000\
\024\000\000\000\024\000\000\000\000\000\000\000\024\000\000\000\
\024\000\011\000\011\000\000\000\000\000\011\000\011\000\011\000\
\011\000\011\000\000\000\011\000\000\000\000\000\000\000\011\000\
\000\000\011\000\007\000\007\000\000\000\000\000\007\000\007\000\
\007\000\007\000\007\000\000\000\007\000\000\000\000\000\000\000\
\007\000\000\000\007\000\008\000\008\000\000\000\000\000\008\000\
\008\000\008\000\008\000\008\000\000\000\008\000\000\000\000\000\
\000\000\008\000\000\000\008\000\002\000\002\000\002\000\002\000\
\002\000\000\000\002\000\000\000\000\000\000\000\002\000\000\000\
\002\000\003\000\003\000\003\000\003\000\003\000\000\000\003\000\
\000\000\000\000\000\000\003\000\000\000\003\000\005\000\005\000\
\005\000\005\000\005\000\000\000\005\000\000\000\000\000\000\000\
\005\000\000\000\005\000\004\000\004\000\004\000\004\000\004\000\
\000\000\004\000\000\000\000\000\000\000\004\000\000\000\004\000\
\006\000\006\000\006\000\006\000\006\000\000\000\006\000\000\000\
\000\000\000\000\006\000\000\000\006\000"

let yycheck = "\001\000\
\000\000\008\001\009\001\010\001\011\001\012\001\013\001\014\001\
\015\001\016\001\009\000\010\000\017\001\000\000\013\000\014\000\
\021\001\000\000\017\000\018\000\019\000\020\000\021\000\022\000\
\023\000\024\000\025\000\008\001\009\001\010\001\011\001\010\001\
\011\001\018\001\000\000\018\001\018\001\043\000\255\255\255\255\
\039\000\008\001\009\001\010\001\011\001\012\001\013\001\014\001\
\015\001\016\001\001\001\000\000\003\001\004\001\005\001\006\001\
\007\001\024\001\009\001\255\255\255\255\255\255\255\255\255\255\
\000\000\255\255\017\001\008\001\009\001\010\001\011\001\012\001\
\013\001\014\001\015\001\016\001\255\255\000\000\255\255\255\255\
\255\255\022\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\000\000\008\001\009\001\010\001\011\001\012\001\
\013\001\014\001\015\001\016\001\255\255\018\001\255\255\000\000\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\000\000\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\255\255\018\001\255\255\255\255\255\255\022\001\255\255\
\024\001\008\001\009\001\255\255\255\255\012\001\013\001\014\001\
\015\001\016\001\255\255\018\001\255\255\255\255\255\255\022\001\
\255\255\024\001\008\001\009\001\255\255\255\255\012\001\013\001\
\014\001\015\001\016\001\255\255\018\001\255\255\255\255\255\255\
\022\001\255\255\024\001\008\001\009\001\255\255\255\255\012\001\
\013\001\014\001\015\001\016\001\255\255\018\001\255\255\255\255\
\255\255\022\001\255\255\024\001\012\001\013\001\014\001\015\001\
\016\001\255\255\018\001\255\255\255\255\255\255\022\001\255\255\
\024\001\012\001\013\001\014\001\015\001\016\001\255\255\018\001\
\255\255\255\255\255\255\022\001\255\255\024\001\012\001\013\001\
\014\001\015\001\016\001\255\255\018\001\255\255\255\255\255\255\
\022\001\255\255\024\001\012\001\013\001\014\001\015\001\016\001\
\255\255\018\001\255\255\255\255\255\255\022\001\255\255\024\001\
\012\001\013\001\014\001\015\001\016\001\255\255\018\001\255\255\
\255\255\255\255\022\001\255\255\024\001"

let yynames_const = "\
  EOF\000\
  TRUE\000\
  FALSE\000\
  UNIT\000\
  PLUS\000\
  MINUS\000\
  MULT\000\
  DIV\000\
  EQUALEQUAL\000\
  GREATER\000\
  SMALLER\000\
  GREATEREQUAL\000\
  SMALLEREQUAL\000\
  LPAREN\000\
  RPAREN\000\
  LSIMPLEBRACE\000\
  RSIMPLEBRACE\000\
  LBRACKET\000\
  RBRACKET\000\
  SEMICOLON\000\
  COMMA\000\
  DOUBLEDOT\000\
  RETURN\000\
  LET\000\
  PRINT\000\
  FOR\000\
  WHILE\000\
  LOOP\000\
  IF\000\
  ELSE\000\
  ELSIF\000\
  "

let yynames_block = "\
  INT\000\
  FLOAT\000\
  STRING\000\
  IDENT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'opt_exprs) in
    Obj.repr(
# 42 "textemplatecoreparser.mly"
                                     ( App (_1, _3) )
# 297 "textemplatecoreparser.ml"
               : Textemplatecoreast.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Textemplatecoreast.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Textemplatecoreast.expr) in
    Obj.repr(
# 43 "textemplatecoreparser.mly"
                                 ( Binop ("==", _1, _3) )
# 305 "textemplatecoreparser.ml"
               : Textemplatecoreast.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Textemplatecoreast.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Textemplatecoreast.expr) in
    Obj.repr(
# 44 "textemplatecoreparser.mly"
                                 ( Binop (">", _1, _3) )
# 313 "textemplatecoreparser.ml"
               : Textemplatecoreast.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Textemplatecoreast.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Textemplatecoreast.expr) in
    Obj.repr(
# 45 "textemplatecoreparser.mly"
                                 ( Binop (">=", _1, _3) )
# 321 "textemplatecoreparser.ml"
               : Textemplatecoreast.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Textemplatecoreast.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Textemplatecoreast.expr) in
    Obj.repr(
# 46 "textemplatecoreparser.mly"
                                 ( Binop ("<", _1, _3) )
# 329 "textemplatecoreparser.ml"
               : Textemplatecoreast.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Textemplatecoreast.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Textemplatecoreast.expr) in
    Obj.repr(
# 47 "textemplatecoreparser.mly"
                                 ( Binop ("<=", _1, _3) )
# 337 "textemplatecoreparser.ml"
               : Textemplatecoreast.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Textemplatecoreast.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Textemplatecoreast.expr) in
    Obj.repr(
# 48 "textemplatecoreparser.mly"
                                 ( Binop ("+", _1, _3) )
# 345 "textemplatecoreparser.ml"
               : Textemplatecoreast.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Textemplatecoreast.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Textemplatecoreast.expr) in
    Obj.repr(
# 49 "textemplatecoreparser.mly"
                                 ( Binop ("-", _1, _3) )
# 353 "textemplatecoreparser.ml"
               : Textemplatecoreast.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Textemplatecoreast.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Textemplatecoreast.expr) in
    Obj.repr(
# 50 "textemplatecoreparser.mly"
                                 ( Binop ("*", _1, _3) )
# 361 "textemplatecoreparser.ml"
               : Textemplatecoreast.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Textemplatecoreast.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Textemplatecoreast.expr) in
    Obj.repr(
# 51 "textemplatecoreparser.mly"
                                 ( Binop ("/", _1, _3) )
# 369 "textemplatecoreparser.ml"
               : Textemplatecoreast.expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Textemplatecoreast.expr) in
    Obj.repr(
# 52 "textemplatecoreparser.mly"
                                 ( Monop ("-", _2) )
# 376 "textemplatecoreparser.ml"
               : Textemplatecoreast.expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Textemplatecoreast.expr) in
    Obj.repr(
# 53 "textemplatecoreparser.mly"
                                     ( _2 )
# 383 "textemplatecoreparser.ml"
               : Textemplatecoreast.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 54 "textemplatecoreparser.mly"
                                 ( _1 )
# 390 "textemplatecoreparser.ml"
               : Textemplatecoreast.expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Textemplatecoreast.expr) in
    Obj.repr(
# 55 "textemplatecoreparser.mly"
                                 ( ArrayRead (_1, _3) )
# 398 "textemplatecoreparser.ml"
               : Textemplatecoreast.expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 59 "textemplatecoreparser.mly"
  ( [] )
# 404 "textemplatecoreparser.ml"
               : 'opt_exprs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Textemplatecoreast.expr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'exprs) in
    Obj.repr(
# 60 "textemplatecoreparser.mly"
                           ( _1 :: _2 )
# 412 "textemplatecoreparser.ml"
               : 'opt_exprs))
; (fun __caml_parser_env ->
    Obj.repr(
# 64 "textemplatecoreparser.mly"
  ( [] )
# 418 "textemplatecoreparser.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Textemplatecoreast.expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exprs) in
    Obj.repr(
# 65 "textemplatecoreparser.mly"
                           ( _2 :: _3 )
# 426 "textemplatecoreparser.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    Obj.repr(
# 69 "textemplatecoreparser.mly"
                 ( Unit )
# 432 "textemplatecoreparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 70 "textemplatecoreparser.mly"
                 ( Int (_1) )
# 439 "textemplatecoreparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 71 "textemplatecoreparser.mly"
                 ( Bool (true) )
# 445 "textemplatecoreparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 72 "textemplatecoreparser.mly"
                 ( Bool (false) )
# 451 "textemplatecoreparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 73 "textemplatecoreparser.mly"
                 ( String (_1) )
# 458 "textemplatecoreparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 74 "textemplatecoreparser.mly"
                 ( Ident (_1) )
# 465 "textemplatecoreparser.ml"
               : 'atom))
(* Entry expr *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let expr (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Textemplatecoreast.expr)
