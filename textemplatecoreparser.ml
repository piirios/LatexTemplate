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
  | FN

open Parsing
let _ = parse_error;;
# 2 "textemplatecoreparser.mly"
    open Textemplatecoreast ;;
# 64 "textemplatecoreparser.ml"
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
  296 (* FN *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* FLOAT *);
  259 (* STRING *);
  260 (* IDENT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\003\000\003\000\006\000\007\000\
\007\000\009\000\009\000\010\000\010\000\010\000\010\000\012\000\
\012\000\008\000\005\000\005\000\005\000\005\000\005\000\005\000\
\005\000\005\000\005\000\005\000\005\000\004\000\004\000\004\000\
\004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
\004\000\004\000\004\000\004\000\004\000\014\000\014\000\014\000\
\013\000\013\000\011\000\011\000\015\000\015\000\015\000\015\000\
\015\000\015\000\000\000"

let yylen = "\002\000\
\001\000\001\000\002\000\002\000\001\000\001\000\006\000\000\000\
\002\000\000\000\003\000\004\000\005\000\006\000\007\000\001\000\
\002\000\003\000\005\000\003\000\002\000\005\000\002\000\004\000\
\007\000\003\000\005\000\005\000\002\000\004\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\002\000\
\003\000\001\000\004\000\003\000\002\000\000\000\001\000\003\000\
\000\000\001\000\000\000\003\000\001\000\001\000\001\000\001\000\
\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\002\000\054\000\057\000\000\000\055\000\056\000\
\053\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\059\000\001\000\000\000\000\000\
\005\000\006\000\000\000\042\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\021\000\000\000\029\000\000\000\003\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\004\000\000\000\023\000\000\000\000\000\000\000\000\000\000\000\
\000\000\041\000\026\000\000\000\000\000\000\000\000\000\020\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\024\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\017\000\018\000\000\000\000\000\
\000\000\048\000\027\000\000\000\030\000\043\000\000\000\000\000\
\000\000\000\000\028\000\022\000\000\000\000\000\019\000\000\000\
\009\000\000\000\000\000\000\000\014\000\000\000\000\000\000\000\
\000\000\007\000\025\000\052\000\015\000\011\000"

let yydgoto = "\002\000\
\021\000\022\000\023\000\061\000\025\000\026\000\105\000\043\000\
\121\000\027\000\112\000\075\000\036\000\062\000\028\000"

let yysindex = "\004\000\
\001\000\000\000\000\000\000\000\000\000\253\254\000\000\000\000\
\000\000\193\000\193\000\193\000\010\255\255\254\015\255\193\000\
\000\255\193\000\002\255\025\255\000\000\000\000\001\000\161\255\
\000\000\000\000\013\255\000\000\193\000\193\000\193\000\043\255\
\034\255\180\255\166\000\018\255\049\255\055\255\193\000\042\255\
\199\255\003\255\000\000\199\255\000\000\061\255\000\000\193\000\
\193\000\193\000\193\000\193\000\193\000\193\000\193\000\193\000\
\000\000\193\000\000\000\219\255\033\000\062\255\052\000\193\000\
\193\000\000\000\000\000\068\255\074\255\063\255\193\000\000\000\
\056\255\003\255\064\255\048\255\084\255\034\255\034\255\067\255\
\067\255\014\255\014\255\014\255\014\255\014\255\166\000\000\000\
\193\000\065\255\082\255\080\255\071\000\075\255\166\000\108\255\
\077\255\199\255\193\000\193\000\000\000\000\000\000\255\078\255\
\083\255\000\000\000\000\193\000\000\000\000\000\193\000\081\255\
\075\255\166\000\000\000\000\000\086\255\090\000\000\000\104\255\
\000\000\000\255\239\255\109\000\000\000\091\255\065\255\082\255\
\078\255\000\000\000\000\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\128\000\000\000\000\000\
\000\000\000\000\000\000\092\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\099\255\000\000\123\255\
\240\000\000\000\095\255\000\000\000\000\000\000\099\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\142\255\000\000\000\000\101\255\000\000\000\000\099\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\100\255\000\000\000\000\103\255\002\001\020\001\204\000\
\222\000\002\000\034\001\048\001\062\001\076\001\072\255\000\000\
\099\255\175\000\147\000\000\000\000\000\102\255\105\255\000\000\
\000\000\000\000\099\255\000\000\000\000\000\000\000\000\109\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\102\255\116\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\102\255\000\000\000\000\000\000\000\000\
\109\255\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\101\000\000\000\255\255\226\255\000\000\000\000\218\255\
\252\255\000\000\145\255\054\000\000\000\225\255\000\000"

let yytablesize = 614
let yytable = "\024\000\
\003\000\126\000\072\000\029\000\001\000\076\000\073\000\070\000\
\033\000\034\000\035\000\074\000\132\000\037\000\041\000\030\000\
\044\000\039\000\040\000\031\000\042\000\024\000\048\000\049\000\
\050\000\051\000\045\000\060\000\046\000\063\000\012\000\013\000\
\092\000\014\000\015\000\016\000\017\000\059\000\018\000\038\000\
\058\000\019\000\067\000\074\000\050\000\051\000\078\000\079\000\
\080\000\081\000\082\000\083\000\084\000\085\000\086\000\068\000\
\087\000\106\000\069\000\116\000\058\000\064\000\029\000\093\000\
\119\000\065\000\095\000\117\000\004\000\098\000\005\000\032\000\
\007\000\008\000\099\000\009\000\071\000\010\000\100\000\077\000\
\096\000\090\000\097\000\130\000\103\000\102\000\011\000\104\000\
\108\000\107\000\094\000\044\000\044\000\058\000\114\000\044\000\
\044\000\044\000\118\000\109\000\111\000\115\000\122\000\120\000\
\125\000\127\000\123\000\129\000\004\000\124\000\005\000\032\000\
\007\000\008\000\133\000\009\000\049\000\010\000\046\000\050\000\
\047\000\016\000\008\000\047\000\134\000\051\000\011\000\101\000\
\010\000\012\000\113\000\058\000\058\000\058\000\058\000\058\000\
\058\000\058\000\058\000\058\000\013\000\000\000\058\000\058\000\
\000\000\000\000\058\000\058\000\058\000\058\000\045\000\000\000\
\045\000\045\000\045\000\045\000\045\000\045\000\045\000\000\000\
\000\000\045\000\045\000\000\000\000\000\045\000\045\000\045\000\
\045\000\048\000\049\000\050\000\051\000\052\000\053\000\054\000\
\055\000\056\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\057\000\000\000\058\000\048\000\049\000\050\000\051\000\
\052\000\053\000\054\000\055\000\056\000\000\000\000\000\066\000\
\000\000\000\000\000\000\000\000\000\000\000\000\058\000\048\000\
\049\000\050\000\051\000\052\000\053\000\054\000\055\000\056\000\
\000\000\000\000\000\000\042\000\000\000\000\000\000\000\000\000\
\000\000\058\000\000\000\048\000\049\000\050\000\051\000\052\000\
\053\000\054\000\055\000\056\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\088\000\000\000\058\000\000\000\048\000\
\049\000\050\000\051\000\052\000\053\000\054\000\055\000\056\000\
\000\000\004\000\000\000\005\000\006\000\007\000\008\000\131\000\
\009\000\058\000\010\000\000\000\000\000\000\000\031\000\031\000\
\031\000\031\000\031\000\011\000\000\000\031\000\031\000\000\000\
\000\000\031\000\031\000\031\000\012\000\013\000\000\000\014\000\
\015\000\016\000\017\000\000\000\018\000\000\000\000\000\019\000\
\020\000\048\000\049\000\050\000\051\000\052\000\053\000\054\000\
\055\000\056\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\089\000\058\000\048\000\049\000\050\000\051\000\
\052\000\053\000\054\000\055\000\056\000\000\000\000\000\000\000\
\000\000\000\000\000\000\091\000\000\000\000\000\058\000\048\000\
\049\000\050\000\051\000\052\000\053\000\054\000\055\000\056\000\
\000\000\000\000\000\000\000\000\000\000\000\000\110\000\000\000\
\000\000\058\000\048\000\049\000\050\000\051\000\052\000\053\000\
\054\000\055\000\056\000\000\000\000\000\000\000\000\000\000\000\
\000\000\128\000\000\000\000\000\058\000\048\000\049\000\050\000\
\051\000\052\000\053\000\054\000\055\000\056\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\111\000\058\000\
\058\000\058\000\058\000\058\000\058\000\058\000\058\000\058\000\
\058\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\058\000\000\000\058\000\043\000\043\000\043\000\043\000\043\000\
\043\000\043\000\043\000\043\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\043\000\000\000\043\000\048\000\049\000\
\050\000\051\000\052\000\053\000\054\000\055\000\056\000\030\000\
\030\000\030\000\030\000\030\000\030\000\030\000\030\000\030\000\
\058\000\004\000\000\000\005\000\032\000\007\000\008\000\000\000\
\009\000\030\000\010\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\011\000\038\000\038\000\038\000\038\000\
\038\000\038\000\038\000\038\000\038\000\000\000\000\000\038\000\
\038\000\000\000\000\000\038\000\038\000\038\000\039\000\039\000\
\039\000\039\000\039\000\039\000\039\000\039\000\039\000\000\000\
\000\000\039\000\039\000\000\000\000\000\039\000\039\000\039\000\
\040\000\040\000\000\000\000\000\040\000\040\000\040\000\040\000\
\040\000\000\000\000\000\040\000\040\000\000\000\000\000\040\000\
\040\000\040\000\036\000\036\000\000\000\000\000\036\000\036\000\
\036\000\036\000\036\000\000\000\000\000\036\000\036\000\000\000\
\000\000\036\000\036\000\036\000\037\000\037\000\000\000\000\000\
\037\000\037\000\037\000\037\000\037\000\000\000\000\000\037\000\
\037\000\000\000\000\000\037\000\037\000\037\000\032\000\032\000\
\032\000\032\000\032\000\000\000\000\000\032\000\032\000\000\000\
\000\000\032\000\032\000\032\000\034\000\034\000\034\000\034\000\
\034\000\000\000\000\000\034\000\034\000\000\000\000\000\034\000\
\034\000\034\000\033\000\033\000\033\000\033\000\033\000\000\000\
\000\000\033\000\033\000\000\000\000\000\033\000\033\000\033\000\
\035\000\035\000\035\000\035\000\035\000\000\000\000\000\035\000\
\035\000\000\000\000\000\035\000\035\000\035\000"

let yycheck = "\001\000\
\000\000\113\000\041\000\007\001\001\000\044\000\004\001\039\000\
\010\000\011\000\012\000\042\000\124\000\004\001\016\000\019\001\
\018\000\019\001\004\001\023\001\021\001\023\000\009\001\010\001\
\011\001\012\001\025\001\029\000\004\001\031\000\028\001\029\001\
\064\000\031\001\032\001\033\001\034\001\025\001\036\001\030\001\
\027\001\039\001\025\001\074\000\011\001\012\001\048\000\049\000\
\050\000\051\000\052\000\053\000\054\000\055\000\056\000\007\001\
\058\000\089\000\004\001\098\000\027\001\019\001\007\001\065\000\
\103\000\023\001\068\000\099\000\001\001\071\000\003\001\004\001\
\005\001\006\001\019\001\008\001\035\001\010\001\023\001\019\001\
\007\001\020\001\020\001\122\000\037\001\022\001\019\001\004\001\
\007\001\025\001\023\001\020\001\021\001\027\001\096\000\024\001\
\025\001\026\001\100\000\020\001\026\001\025\001\020\001\026\001\
\024\001\020\001\108\000\004\001\001\001\111\000\003\001\004\001\
\005\001\006\001\024\001\008\001\025\001\010\001\020\001\025\001\
\020\001\022\001\020\001\023\000\129\000\024\001\019\001\074\000\
\020\001\025\001\023\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\025\001\255\255\020\001\021\001\
\255\255\255\255\024\001\025\001\026\001\027\001\009\001\255\255\
\011\001\012\001\013\001\014\001\015\001\016\001\017\001\255\255\
\255\255\020\001\021\001\255\255\255\255\024\001\025\001\026\001\
\027\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\025\001\255\255\027\001\009\001\010\001\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\255\255\255\255\020\001\
\255\255\255\255\255\255\255\255\255\255\255\255\027\001\009\001\
\010\001\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\255\255\255\255\255\255\021\001\255\255\255\255\255\255\255\255\
\255\255\027\001\255\255\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\025\001\255\255\027\001\255\255\009\001\
\010\001\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\255\255\001\001\255\255\003\001\004\001\005\001\006\001\025\001\
\008\001\027\001\010\001\255\255\255\255\255\255\013\001\014\001\
\015\001\016\001\017\001\019\001\255\255\020\001\021\001\255\255\
\255\255\024\001\025\001\026\001\028\001\029\001\255\255\031\001\
\032\001\033\001\034\001\255\255\036\001\255\255\255\255\039\001\
\040\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\026\001\027\001\009\001\010\001\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\255\255\255\255\255\255\
\255\255\255\255\255\255\024\001\255\255\255\255\027\001\009\001\
\010\001\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\255\255\255\255\255\255\255\255\255\255\255\255\024\001\255\255\
\255\255\027\001\009\001\010\001\011\001\012\001\013\001\014\001\
\015\001\016\001\017\001\255\255\255\255\255\255\255\255\255\255\
\255\255\024\001\255\255\255\255\027\001\009\001\010\001\011\001\
\012\001\013\001\014\001\015\001\016\001\017\001\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\026\001\027\001\
\009\001\010\001\011\001\012\001\013\001\014\001\015\001\016\001\
\017\001\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\025\001\255\255\027\001\009\001\010\001\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\025\001\255\255\027\001\009\001\010\001\
\011\001\012\001\013\001\014\001\015\001\016\001\017\001\009\001\
\010\001\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\027\001\001\001\255\255\003\001\004\001\005\001\006\001\255\255\
\008\001\027\001\010\001\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\019\001\009\001\010\001\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\255\255\255\255\020\001\
\021\001\255\255\255\255\024\001\025\001\026\001\009\001\010\001\
\011\001\012\001\013\001\014\001\015\001\016\001\017\001\255\255\
\255\255\020\001\021\001\255\255\255\255\024\001\025\001\026\001\
\009\001\010\001\255\255\255\255\013\001\014\001\015\001\016\001\
\017\001\255\255\255\255\020\001\021\001\255\255\255\255\024\001\
\025\001\026\001\009\001\010\001\255\255\255\255\013\001\014\001\
\015\001\016\001\017\001\255\255\255\255\020\001\021\001\255\255\
\255\255\024\001\025\001\026\001\009\001\010\001\255\255\255\255\
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
  FN\000\
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
# 44 "textemplatecoreparser.mly"
               ( {core= _1} )
# 408 "textemplatecoreparser.ml"
               : Textemplatecoreast.componant))
; (fun __caml_parser_env ->
    Obj.repr(
# 48 "textemplatecoreparser.mly"
      ( [] )
# 414 "textemplatecoreparser.ml"
               : 'toplevel_lst))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'toplevel) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'toplevel_lst) in
    Obj.repr(
# 49 "textemplatecoreparser.mly"
                        ( _1 :: _2 )
# 422 "textemplatecoreparser.ml"
               : 'toplevel_lst))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 53 "textemplatecoreparser.mly"
                 ( Expression _1 )
# 429 "textemplatecoreparser.ml"
               : 'toplevel))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 54 "textemplatecoreparser.mly"
        ( Instruction _1 )
# 436 "textemplatecoreparser.ml"
               : 'toplevel))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'fun_def) in
    Obj.repr(
# 55 "textemplatecoreparser.mly"
          ( Function _1 )
# 443 "textemplatecoreparser.ml"
               : 'toplevel))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'opt_params) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'instr_scope) in
    Obj.repr(
# 62 "textemplatecoreparser.mly"
    ( { f_name = _2 ; params = _4 ; body = _6 } )
# 452 "textemplatecoreparser.ml"
               : 'fun_def))
; (fun __caml_parser_env ->
    Obj.repr(
# 66 "textemplatecoreparser.mly"
  ( [] )
# 458 "textemplatecoreparser.ml"
               : 'opt_params))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 67 "textemplatecoreparser.mly"
               ( _1 :: _2 )
# 466 "textemplatecoreparser.ml"
               : 'opt_params))
; (fun __caml_parser_env ->
    Obj.repr(
# 71 "textemplatecoreparser.mly"
  ( [] )
# 472 "textemplatecoreparser.ml"
               : 'params))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 72 "textemplatecoreparser.mly"
                     ( _2 :: _3 )
# 480 "textemplatecoreparser.ml"
               : 'params))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 78 "textemplatecoreparser.mly"
                            ( Declare (_2, Immutable, Scalar _4) )
# 488 "textemplatecoreparser.ml"
               : 'var_decl_content))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 79 "textemplatecoreparser.mly"
                                ( Declare (_3, Mutable, Scalar _5) )
# 496 "textemplatecoreparser.ml"
               : 'var_decl_content))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'exprs) in
    Obj.repr(
# 80 "textemplatecoreparser.mly"
                                               ( Declare (_2, Immutable, Array _5) )
# 504 "textemplatecoreparser.ml"
               : 'var_decl_content))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'exprs) in
    Obj.repr(
# 81 "textemplatecoreparser.mly"
                                                   ( Declare (_3, Mutable, Array _6) )
# 512 "textemplatecoreparser.ml"
               : 'var_decl_content))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 87 "textemplatecoreparser.mly"
        ( [_1] )
# 519 "textemplatecoreparser.ml"
               : 'instrs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'instrs) in
    Obj.repr(
# 88 "textemplatecoreparser.mly"
               ( _1 :: _2 )
# 527 "textemplatecoreparser.ml"
               : 'instrs))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'instrs) in
    Obj.repr(
# 92 "textemplatecoreparser.mly"
                                   ( _2 )
# 534 "textemplatecoreparser.ml"
               : 'instr_scope))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'instr_scope) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'instr_scope) in
    Obj.repr(
# 96 "textemplatecoreparser.mly"
    ( If (_2, _3, _5) )
# 543 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'instr_scope) in
    Obj.repr(
# 98 "textemplatecoreparser.mly"
    ( While (_2, _3) )
# 551 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'instr_scope) in
    Obj.repr(
# 100 "textemplatecoreparser.mly"
    ( Loop (_2) )
# 558 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'instr_scope) in
    Obj.repr(
# 102 "textemplatecoreparser.mly"
    ( For (_2, _4, _5) )
# 567 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'var_decl_content) in
    Obj.repr(
# 103 "textemplatecoreparser.mly"
                             ( _1 )
# 574 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 105 "textemplatecoreparser.mly"
    ( Assign (_1, _3) )
# 582 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 107 "textemplatecoreparser.mly"
    ( ArrayWrite (_1, _3, _6) )
# 591 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'opt_expr) in
    Obj.repr(
# 109 "textemplatecoreparser.mly"
    ( Return _2 )
# 598 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'opt_exprs) in
    Obj.repr(
# 111 "textemplatecoreparser.mly"
    ( Iapp (_1, _3) )
# 606 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'opt_exprs) in
    Obj.repr(
# 113 "textemplatecoreparser.mly"
    ( Print _3 )
# 613 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    Obj.repr(
# 115 "textemplatecoreparser.mly"
    ( Break )
# 619 "textemplatecoreparser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'opt_exprs) in
    Obj.repr(
# 120 "textemplatecoreparser.mly"
                                     ( App (_1, _3) )
# 627 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 121 "textemplatecoreparser.mly"
                                 ( Binop ("==", _1, _3) )
# 635 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 122 "textemplatecoreparser.mly"
                                 ( Binop (">", _1, _3) )
# 643 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 123 "textemplatecoreparser.mly"
                                 ( Binop (">=", _1, _3) )
# 651 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 124 "textemplatecoreparser.mly"
                                 ( Binop ("<", _1, _3) )
# 659 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 125 "textemplatecoreparser.mly"
                                 ( Binop ("<=", _1, _3) )
# 667 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 126 "textemplatecoreparser.mly"
                                 ( Binop ("+", _1, _3) )
# 675 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 127 "textemplatecoreparser.mly"
                                 ( Binop ("-", _1, _3) )
# 683 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 128 "textemplatecoreparser.mly"
                                 ( Binop ("*", _1, _3) )
# 691 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 129 "textemplatecoreparser.mly"
                                 ( Binop ("/", _1, _3) )
# 699 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 130 "textemplatecoreparser.mly"
                                 ( Monop ("-", _2) )
# 706 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 131 "textemplatecoreparser.mly"
                                     ( _2 )
# 713 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 132 "textemplatecoreparser.mly"
                                 ( _1 )
# 720 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 133 "textemplatecoreparser.mly"
                                 ( ArrayRead (_1, _3) )
# 728 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 134 "textemplatecoreparser.mly"
                                 ( Range (_1, Some _3) )
# 736 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 135 "textemplatecoreparser.mly"
                                 ( Range (_1, None) )
# 743 "textemplatecoreparser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 139 "textemplatecoreparser.mly"
  ( [] )
# 749 "textemplatecoreparser.ml"
               : 'opt_exprs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 140 "textemplatecoreparser.mly"
       ( [_1] )
# 756 "textemplatecoreparser.ml"
               : 'opt_exprs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'opt_exprs) in
    Obj.repr(
# 141 "textemplatecoreparser.mly"
                                     ( _1 :: _3 )
# 764 "textemplatecoreparser.ml"
               : 'opt_exprs))
; (fun __caml_parser_env ->
    Obj.repr(
# 145 "textemplatecoreparser.mly"
  ( Unit )
# 770 "textemplatecoreparser.ml"
               : 'opt_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 146 "textemplatecoreparser.mly"
                     ( _1 )
# 777 "textemplatecoreparser.ml"
               : 'opt_expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 150 "textemplatecoreparser.mly"
  ( [] )
# 783 "textemplatecoreparser.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exprs) in
    Obj.repr(
# 151 "textemplatecoreparser.mly"
                           ( _2 :: _3 )
# 791 "textemplatecoreparser.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    Obj.repr(
# 155 "textemplatecoreparser.mly"
                 ( Unit )
# 797 "textemplatecoreparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 156 "textemplatecoreparser.mly"
                 ( Int (_1) )
# 804 "textemplatecoreparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 157 "textemplatecoreparser.mly"
                 ( Bool (true) )
# 810 "textemplatecoreparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 158 "textemplatecoreparser.mly"
                 ( Bool (false) )
# 816 "textemplatecoreparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 159 "textemplatecoreparser.mly"
                 ( String (_1) )
# 823 "textemplatecoreparser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 160 "textemplatecoreparser.mly"
                 ( Ident (_1) )
# 830 "textemplatecoreparser.ml"
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
