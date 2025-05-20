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
  | COLONEQUAL
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
  | MUT
  | PRINT
  | FOR
  | WHILE
  | LOOP
  | IN
  | IF
  | ELSE
  | ELSIF
  | BREAK

open Parsing
let _ = parse_error;;
# 2 "textemplatecoreparser.mly"
    open Textemplatecoreast ;;
# 63 "textemplatecoreparser.ml"
let yytransl_const = [|
    0 (* EOF *);
  261 (* TRUE *);
  262 (* FALSE *);
  263 (* COLONEQUAL *);
  264 (* UNIT *);
  265 (* PLUS *);
  266 (* MINUS *);
  267 (* MULT *);
  268 (* DIV *);
  269 (* EQUALEQUAL *);
  270 (* GREATER *);
  271 (* SMALLER *);
  272 (* GREATEREQUAL *);
  273 (* SMALLEREQUAL *);
  275 (* LPAREN *);
  276 (* RPAREN *);
  277 (* LSIMPLEBRACE *);
  278 (* RSIMPLEBRACE *);
  279 (* LBRACKET *);
  280 (* RBRACKET *);
  281 (* SEMICOLON *);
  282 (* COMMA *);
  283 (* DOUBLEDOT *);
  284 (* RETURN *);
  285 (* LET *);
  286 (* MUT *);
  287 (* PRINT *);
  288 (* FOR *);
  289 (* WHILE *);
  290 (* LOOP *);
  291 (* IN *);
  292 (* IF *);
  293 (* ELSE *);
  294 (* ELSIF *);
  295 (* BREAK *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* FLOAT *);
  259 (* STRING *);
  260 (* IDENT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\003\000\006\000\006\000\006\000\
\006\000\008\000\008\000\009\000\005\000\005\000\005\000\005\000\
\005\000\005\000\005\000\005\000\005\000\005\000\005\000\004\000\
\004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
\004\000\004\000\004\000\004\000\004\000\004\000\004\000\011\000\
\011\000\011\000\010\000\010\000\007\000\007\000\012\000\012\000\
\012\000\012\000\012\000\012\000\000\000"

let yylen = "\002\000\
\001\000\001\000\002\000\002\000\001\000\004\000\005\000\006\000\
\007\000\001\000\002\000\003\000\005\000\003\000\002\000\005\000\
\002\000\004\000\007\000\003\000\005\000\005\000\002\000\004\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\002\000\003\000\001\000\004\000\003\000\002\000\000\000\
\001\000\003\000\000\000\001\000\000\000\003\000\001\000\001\000\
\001\000\001\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\002\000\048\000\051\000\000\000\049\000\050\000\
\047\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\053\000\001\000\000\000\000\000\005\000\
\000\000\036\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\015\000\000\000\023\000\003\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\004\000\000\000\017\000\
\000\000\000\000\000\000\000\000\000\000\000\000\035\000\020\000\
\000\000\000\000\000\000\000\000\014\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\018\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\011\000\012\000\000\000\042\000\021\000\000\000\024\000\037\000\
\000\000\000\000\000\000\000\000\022\000\016\000\000\000\000\000\
\013\000\000\000\000\000\008\000\000\000\000\000\000\000\019\000\
\046\000\009\000"

let yydgoto = "\002\000\
\020\000\021\000\022\000\058\000\024\000\025\000\106\000\072\000\
\041\000\034\000\059\000\026\000"

let yysindex = "\011\000\
\001\000\000\000\000\000\000\000\000\000\253\254\000\000\000\000\
\000\000\009\000\009\000\009\000\255\254\250\254\019\255\009\000\
\003\255\009\000\000\255\000\000\000\000\001\000\134\255\000\000\
\002\255\000\000\009\000\009\000\009\000\037\255\007\255\153\255\
\146\000\005\255\032\255\038\255\009\000\006\255\172\255\004\255\
\000\000\172\255\000\000\000\000\009\000\009\000\009\000\009\000\
\009\000\009\000\009\000\009\000\009\000\000\000\009\000\000\000\
\191\255\210\255\039\255\229\255\009\000\009\000\000\000\000\000\
\065\255\051\255\043\255\009\000\000\000\095\255\004\255\050\255\
\045\255\007\255\007\255\053\255\053\255\088\255\088\255\088\255\
\088\255\088\255\146\000\000\000\009\000\060\255\079\255\067\255\
\032\000\063\255\146\000\073\255\068\255\172\255\009\000\009\000\
\000\000\000\000\003\255\000\000\000\000\009\000\000\000\000\000\
\009\000\066\255\063\255\146\000\000\000\000\000\074\255\051\000\
\000\000\070\000\089\000\000\000\101\255\060\255\079\255\000\000\
\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\108\000\000\000\000\000\
\000\000\000\000\000\000\000\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\083\255\000\000\096\255\210\000\000\000\
\094\255\000\000\000\000\000\000\083\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\115\255\000\000\
\000\000\113\255\000\000\000\000\083\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\112\255\000\000\
\000\000\228\000\246\000\174\000\192\000\004\001\018\001\032\001\
\046\001\060\001\132\255\000\000\083\255\155\000\127\000\000\000\
\000\000\114\255\129\255\000\000\000\000\000\000\083\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\114\255\130\255\000\000\000\000\000\000\000\000\
\000\000\000\000\114\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000"

let yygindex = "\000\000\
\000\000\115\000\000\000\255\255\238\255\000\000\155\255\100\000\
\219\255\000\000\226\255\000\000"

let yytablesize = 598
let yytable = "\023\000\
\003\000\069\000\035\000\027\000\073\000\117\000\067\000\070\000\
\031\000\032\000\033\000\001\000\037\000\121\000\039\000\028\000\
\042\000\047\000\048\000\029\000\023\000\071\000\038\000\040\000\
\043\000\057\000\056\000\060\000\036\000\064\000\088\000\012\000\
\013\000\055\000\014\000\015\000\016\000\017\000\065\000\018\000\
\068\000\066\000\019\000\074\000\075\000\076\000\077\000\078\000\
\079\000\080\000\081\000\082\000\071\000\083\000\100\000\061\000\
\110\000\092\000\086\000\062\000\089\000\113\000\093\000\091\000\
\111\000\004\000\094\000\005\000\030\000\007\000\008\000\098\000\
\009\000\004\000\010\000\005\000\030\000\007\000\008\000\055\000\
\009\000\099\000\010\000\011\000\101\000\102\000\103\000\090\000\
\105\000\116\000\108\000\011\000\109\000\118\000\112\000\107\000\
\045\000\046\000\047\000\048\000\114\000\027\000\040\000\115\000\
\052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
\052\000\095\000\055\000\052\000\052\000\096\000\044\000\052\000\
\052\000\052\000\052\000\039\000\122\000\039\000\039\000\039\000\
\039\000\039\000\039\000\039\000\041\000\010\000\039\000\039\000\
\044\000\045\000\039\000\039\000\039\000\039\000\045\000\046\000\
\047\000\048\000\049\000\050\000\051\000\052\000\053\000\038\000\
\038\000\006\000\007\000\038\000\038\000\038\000\054\000\000\000\
\055\000\045\000\046\000\047\000\048\000\049\000\050\000\051\000\
\052\000\053\000\097\000\000\000\063\000\000\000\000\000\000\000\
\000\000\000\000\000\000\055\000\045\000\046\000\047\000\048\000\
\049\000\050\000\051\000\052\000\053\000\000\000\000\000\000\000\
\040\000\000\000\000\000\000\000\000\000\000\000\055\000\045\000\
\046\000\047\000\048\000\049\000\050\000\051\000\052\000\053\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\084\000\
\000\000\055\000\045\000\046\000\047\000\048\000\049\000\050\000\
\051\000\052\000\053\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\085\000\055\000\045\000\046\000\047\000\
\048\000\049\000\050\000\051\000\052\000\053\000\000\000\000\000\
\000\000\000\000\000\000\000\000\087\000\000\000\000\000\055\000\
\000\000\004\000\000\000\005\000\006\000\007\000\008\000\000\000\
\009\000\004\000\010\000\005\000\030\000\007\000\008\000\000\000\
\009\000\000\000\010\000\011\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\011\000\012\000\013\000\000\000\014\000\
\015\000\016\000\017\000\000\000\018\000\000\000\000\000\019\000\
\045\000\046\000\047\000\048\000\049\000\050\000\051\000\052\000\
\053\000\000\000\000\000\000\000\000\000\000\000\000\000\104\000\
\000\000\000\000\055\000\045\000\046\000\047\000\048\000\049\000\
\050\000\051\000\052\000\053\000\000\000\000\000\000\000\000\000\
\000\000\000\000\119\000\000\000\000\000\055\000\045\000\046\000\
\047\000\048\000\049\000\050\000\051\000\052\000\053\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\120\000\000\000\
\055\000\045\000\046\000\047\000\048\000\049\000\050\000\051\000\
\052\000\053\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\105\000\055\000\052\000\052\000\052\000\052\000\
\052\000\052\000\052\000\052\000\052\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\052\000\000\000\052\000\037\000\
\037\000\037\000\037\000\037\000\037\000\037\000\037\000\037\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\037\000\
\000\000\037\000\045\000\046\000\047\000\048\000\049\000\050\000\
\051\000\052\000\053\000\024\000\024\000\024\000\024\000\024\000\
\024\000\024\000\024\000\024\000\055\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\024\000\032\000\032\000\
\032\000\032\000\032\000\032\000\032\000\032\000\032\000\000\000\
\000\000\032\000\032\000\000\000\000\000\032\000\032\000\032\000\
\033\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
\033\000\000\000\000\000\033\000\033\000\000\000\000\000\033\000\
\033\000\033\000\034\000\034\000\000\000\000\000\034\000\034\000\
\034\000\034\000\034\000\000\000\000\000\034\000\034\000\000\000\
\000\000\034\000\034\000\034\000\030\000\030\000\000\000\000\000\
\030\000\030\000\030\000\030\000\030\000\000\000\000\000\030\000\
\030\000\000\000\000\000\030\000\030\000\030\000\031\000\031\000\
\000\000\000\000\031\000\031\000\031\000\031\000\031\000\000\000\
\000\000\031\000\031\000\000\000\000\000\031\000\031\000\031\000\
\025\000\025\000\025\000\025\000\025\000\000\000\000\000\025\000\
\025\000\000\000\000\000\025\000\025\000\025\000\026\000\026\000\
\026\000\026\000\026\000\000\000\000\000\026\000\026\000\000\000\
\000\000\026\000\026\000\026\000\028\000\028\000\028\000\028\000\
\028\000\000\000\000\000\028\000\028\000\000\000\000\000\028\000\
\028\000\028\000\027\000\027\000\027\000\027\000\027\000\000\000\
\000\000\027\000\027\000\000\000\000\000\027\000\027\000\027\000\
\029\000\029\000\029\000\029\000\029\000\000\000\000\000\029\000\
\029\000\000\000\000\000\029\000\029\000\029\000"

let yycheck = "\001\000\
\000\000\039\000\004\001\007\001\042\000\107\000\037\000\004\001\
\010\000\011\000\012\000\001\000\019\001\115\000\016\000\019\001\
\018\000\011\001\012\001\023\001\022\000\040\000\004\001\021\001\
\025\001\027\000\025\001\029\000\030\001\025\001\061\000\028\001\
\029\001\027\001\031\001\032\001\033\001\034\001\007\001\036\001\
\035\001\004\001\039\001\045\000\046\000\047\000\048\000\049\000\
\050\000\051\000\052\000\053\000\071\000\055\000\085\000\019\001\
\094\000\007\001\020\001\023\001\062\000\099\000\020\001\065\000\
\095\000\001\001\068\000\003\001\004\001\005\001\006\001\022\001\
\008\001\001\001\010\001\003\001\004\001\005\001\006\001\027\001\
\008\001\037\001\010\001\019\001\025\001\007\001\020\001\023\001\
\026\001\024\001\092\000\019\001\025\001\020\001\096\000\023\001\
\009\001\010\001\011\001\012\001\102\000\007\001\020\001\105\000\
\009\001\010\001\011\001\012\001\013\001\014\001\015\001\016\001\
\017\001\019\001\027\001\020\001\021\001\023\001\025\001\024\001\
\025\001\026\001\027\001\009\001\024\001\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\020\001\022\001\020\001\021\001\
\022\000\024\001\024\001\025\001\026\001\027\001\009\001\010\001\
\011\001\012\001\013\001\014\001\015\001\016\001\017\001\020\001\
\021\001\025\001\025\001\024\001\025\001\026\001\025\001\255\255\
\027\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\071\000\255\255\020\001\255\255\255\255\255\255\
\255\255\255\255\255\255\027\001\009\001\010\001\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\255\255\255\255\255\255\
\021\001\255\255\255\255\255\255\255\255\255\255\027\001\009\001\
\010\001\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\025\001\
\255\255\027\001\009\001\010\001\011\001\012\001\013\001\014\001\
\015\001\016\001\017\001\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\026\001\027\001\009\001\010\001\011\001\
\012\001\013\001\014\001\015\001\016\001\017\001\255\255\255\255\
\255\255\255\255\255\255\255\255\024\001\255\255\255\255\027\001\
\255\255\001\001\255\255\003\001\004\001\005\001\006\001\255\255\
\008\001\001\001\010\001\003\001\004\001\005\001\006\001\255\255\
\008\001\255\255\010\001\019\001\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\019\001\028\001\029\001\255\255\031\001\
\032\001\033\001\034\001\255\255\036\001\255\255\255\255\039\001\
\009\001\010\001\011\001\012\001\013\001\014\001\015\001\016\001\
\017\001\255\255\255\255\255\255\255\255\255\255\255\255\024\001\
\255\255\255\255\027\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\255\255\255\255\255\255\255\255\
\255\255\255\255\024\001\255\255\255\255\027\001\009\001\010\001\
\011\001\012\001\013\001\014\001\015\001\016\001\017\001\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\025\001\255\255\
\027\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\026\001\027\001\009\001\010\001\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\025\001\255\255\027\001\009\001\
\010\001\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\025\001\
\255\255\027\001\009\001\010\001\011\001\012\001\013\001\014\001\
\015\001\016\001\017\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\027\001\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\027\001\009\001\010\001\
\011\001\012\001\013\001\014\001\015\001\016\001\017\001\255\255\
\255\255\020\001\021\001\255\255\255\255\024\001\025\001\026\001\
\009\001\010\001\011\001\012\001\013\001\014\001\015\001\016\001\
\017\001\255\255\255\255\020\001\021\001\255\255\255\255\024\001\
\025\001\026\001\009\001\010\001\255\255\255\255\013\001\014\001\
\015\001\016\001\017\001\255\255\255\255\020\001\021\001\255\255\
\255\255\024\001\025\001\026\001\009\001\010\001\255\255\255\255\
\013\001\014\001\015\001\016\001\017\001\255\255\255\255\020\001\
\021\001\255\255\255\255\024\001\025\001\026\001\009\001\010\001\
\255\255\255\255\013\001\014\001\015\001\016\001\017\001\255\255\
\255\255\020\001\021\001\255\255\255\255\024\001\025\001\026\001\
\013\001\014\001\015\001\016\001\017\001\255\255\255\255\020\001\
\021\001\255\255\255\255\024\001\025\001\026\001\013\001\014\001\
\015\001\016\001\017\001\255\255\255\255\020\001\021\001\255\255\
\255\255\024\001\025\001\026\001\013\001\014\001\015\001\016\001\
\017\001\255\255\255\255\020\001\021\001\255\255\255\255\024\001\
\025\001\026\001\013\001\014\001\015\001\016\001\017\001\255\255\
\255\255\020\001\021\001\255\255\255\255\024\001\025\001\026\001\
\013\001\014\001\015\001\016\001\017\001\255\255\255\255\020\001\
\021\001\255\255\255\255\024\001\025\001\026\001"

let yynames_const = "\
  EOF\000\
  TRUE\000\
  FALSE\000\
  COLONEQUAL\000\
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
  MUT\000\
  PRINT\000\
  FOR\000\
  WHILE\000\
  LOOP\000\
  IN\000\
  IF\000\
  ELSE\000\
  ELSIF\000\
  BREAK\000\
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
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'toplevel_lst) in
    Obj.repr(
# 43 "textemplatecoreparser.mly"
               ( {core= _1} )
# 396 "textemplatecoreparser.ml"
               : Textemplatecoreast.componant))
; (fun __caml_parser_env ->
    Obj.repr(
# 47 "textemplatecoreparser.mly"
      ( [] )
# 402 "textemplatecoreparser.ml"
               : 'toplevel_lst))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'toplevel) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'toplevel_lst) in
    Obj.repr(
# 48 "textemplatecoreparser.mly"
                        ( _1 :: _2 )
# 410 "textemplatecoreparser.ml"
               : 'toplevel_lst))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 52 "textemplatecoreparser.mly"
                 ( Expression _1 )
# 417 "textemplatecoreparser.ml"
               : 'toplevel))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 53 "textemplatecoreparser.mly"
        ( Instruction _1 )
# 424 "textemplatecoreparser.ml"
               : 'toplevel))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 59 "textemplatecoreparser.mly"
                            ( Declare (_2, Immutable, Scalar _4) )
# 432 "textemplatecoreparser.ml"
               : 'var_decl_content))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 60 "textemplatecoreparser.mly"
                                ( Declare (_3, Mutable, Scalar _5) )
# 440 "textemplatecoreparser.ml"
               : 'var_decl_content))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'exprs) in
    Obj.repr(
# 61 "textemplatecoreparser.mly"
                                               ( Declare (_2, Immutable, Array _5) )
# 448 "textemplatecoreparser.ml"
               : 'var_decl_content))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'exprs) in
    Obj.repr(
# 62 "textemplatecoreparser.mly"
                                                   ( Declare (_3, Mutable, Array _6) )
# 456 "textemplatecoreparser.ml"
               : 'var_decl_content))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 68 "textemplatecoreparser.mly"
        ( [_1] )
# 463 "textemplatecoreparser.ml"
               : 'instrs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'instrs) in
    Obj.repr(
# 69 "textemplatecoreparser.mly"
               ( _1 :: _2 )
# 471 "textemplatecoreparser.ml"
               : 'instrs))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'instrs) in
    Obj.repr(
# 73 "textemplatecoreparser.mly"
                                   ( _2 )
# 478 "textemplatecoreparser.ml"
               : 'instr_scope))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'instr_scope) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'instr_scope) in
    Obj.repr(
# 77 "textemplatecoreparser.mly"
    ( If (_2, _3, _5) )
# 487 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'instr_scope) in
    Obj.repr(
# 79 "textemplatecoreparser.mly"
    ( While (_2, _3) )
# 495 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'instr_scope) in
    Obj.repr(
# 81 "textemplatecoreparser.mly"
    ( Loop (_2) )
# 502 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'instr_scope) in
    Obj.repr(
# 83 "textemplatecoreparser.mly"
    ( For (_2, _4, _5) )
# 511 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'var_decl_content) in
    Obj.repr(
# 84 "textemplatecoreparser.mly"
                             ( _1 )
# 518 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 86 "textemplatecoreparser.mly"
    ( Assign (_1, _3) )
# 526 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 88 "textemplatecoreparser.mly"
    ( ArrayWrite (_1, _3, _6) )
# 535 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'opt_expr) in
    Obj.repr(
# 90 "textemplatecoreparser.mly"
    ( Return _2 )
# 542 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'opt_exprs) in
    Obj.repr(
# 92 "textemplatecoreparser.mly"
    ( Iapp (_1, _3) )
# 550 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'opt_exprs) in
    Obj.repr(
# 94 "textemplatecoreparser.mly"
    ( Print _3 )
# 557 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 96 "textemplatecoreparser.mly"
    ( Break )
# 563 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'opt_exprs) in
    Obj.repr(
# 101 "textemplatecoreparser.mly"
                                     ( App (_1, _3) )
# 571 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 102 "textemplatecoreparser.mly"
                                 ( Binop ("==", _1, _3) )
# 579 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 103 "textemplatecoreparser.mly"
                                 ( Binop (">", _1, _3) )
# 587 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 104 "textemplatecoreparser.mly"
                                 ( Binop (">=", _1, _3) )
# 595 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 105 "textemplatecoreparser.mly"
                                 ( Binop ("<", _1, _3) )
# 603 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 106 "textemplatecoreparser.mly"
                                 ( Binop ("<=", _1, _3) )
# 611 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 107 "textemplatecoreparser.mly"
                                 ( Binop ("+", _1, _3) )
# 619 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 108 "textemplatecoreparser.mly"
                                 ( Binop ("-", _1, _3) )
# 627 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 109 "textemplatecoreparser.mly"
                                 ( Binop ("*", _1, _3) )
# 635 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 110 "textemplatecoreparser.mly"
                                 ( Binop ("/", _1, _3) )
# 643 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 111 "textemplatecoreparser.mly"
                                 ( Monop ("-", _2) )
# 650 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 112 "textemplatecoreparser.mly"
                                     ( _2 )
# 657 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 113 "textemplatecoreparser.mly"
                                 ( _1 )
# 664 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 114 "textemplatecoreparser.mly"
                                 ( ArrayRead (_1, _3) )
# 672 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 115 "textemplatecoreparser.mly"
                                 ( Range (_1, Some _3) )
# 680 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 116 "textemplatecoreparser.mly"
                                 ( Range (_1, None) )
# 687 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 120 "textemplatecoreparser.mly"
  ( [] )
# 693 "textemplatecoreparser.ml"
               : 'opt_exprs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 121 "textemplatecoreparser.mly"
       ( [_1] )
# 700 "textemplatecoreparser.ml"
               : 'opt_exprs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'opt_exprs) in
    Obj.repr(
# 122 "textemplatecoreparser.mly"
                                     ( _1 :: _3 )
# 708 "textemplatecoreparser.ml"
               : 'opt_exprs))
; (fun __caml_parser_env ->
    Obj.repr(
# 126 "textemplatecoreparser.mly"
  ( Unit )
# 714 "textemplatecoreparser.ml"
               : 'opt_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 127 "textemplatecoreparser.mly"
                     ( _1 )
# 721 "textemplatecoreparser.ml"
               : 'opt_expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 131 "textemplatecoreparser.mly"
  ( [] )
# 727 "textemplatecoreparser.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exprs) in
    Obj.repr(
# 132 "textemplatecoreparser.mly"
                           ( _2 :: _3 )
# 735 "textemplatecoreparser.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    Obj.repr(
# 136 "textemplatecoreparser.mly"
                 ( Unit )
# 741 "textemplatecoreparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 137 "textemplatecoreparser.mly"
                 ( Int (_1) )
# 748 "textemplatecoreparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 138 "textemplatecoreparser.mly"
                 ( Bool (true) )
# 754 "textemplatecoreparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 139 "textemplatecoreparser.mly"
                 ( Bool (false) )
# 760 "textemplatecoreparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 140 "textemplatecoreparser.mly"
                 ( String (_1) )
# 767 "textemplatecoreparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 141 "textemplatecoreparser.mly"
                 ( Ident (_1) )
# 774 "textemplatecoreparser.ml"
               : 'atom))
(* Entry componant *)
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
let componant (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Textemplatecoreast.componant)
