%{
    open Textemplatecoreast ;;
%}


// artrithmetique
%token EOF
%token <int> INT 
%token <float> FLOAT 
%token <string> STRING 
%token <string> IDENT
%token TRUE FALSE
%token UNIT PLUS MINUS MULT DIV EQUALEQUAL GREATER SMALLER GREATEREQUAL SMALLEREQUAL

%left EQUALEQUAL GREATER SMALLER GREATEREQUAL SMALLEREQUAL
%left PLUS MINUS
%left MULT DIV
// structure
%token LPAREN RPAREN
%token LSIMPLEBRACE RSIMPLEBRACE
%token LBRACKET RBRACKET
//%token LDOUBLEBRACE RDOUBLEBRACE
%token SEMICOLON COMMA
//%token WHERE
%token DOUBLEDOT

// keywords
%token RETURN 
%token LET
%token PRINT
%token FOR WHILE LOOP
%token IF ELSE ELSIF
%token TRUE FALSE

%start expr_prg
%type <Textemplatecoreast.expr list> expr_prg

%%


expr_prg:
| EOF { [] }
| expr expr_prg { $1 :: $2 }
;

expr:
| IDENT LPAREN opt_exprs RPAREN      { App ($1, $3) }
| expr EQUALEQUAL expr           { Binop ("==", $1, $3) }
| expr GREATER expr              { Binop (">", $1, $3) }
| expr GREATEREQUAL expr         { Binop (">=", $1, $3) }
| expr SMALLER expr              { Binop ("<", $1, $3) }
| expr SMALLEREQUAL expr         { Binop ("<=", $1, $3) }
| expr PLUS expr                 { Binop ("+", $1, $3) }
| expr MINUS expr                { Binop ("-", $1, $3) }
| expr MULT expr                 { Binop ("*", $1, $3) }
| expr DIV expr                  { Binop ("/", $1, $3) }
| MINUS expr                     { Monop ("-", $2) }
| LPAREN expr RPAREN                 { $2 }
| atom                           { $1 }
| IDENT LBRACKET expr RBRACKET   { ArrayRead ($1, $3) }
;

opt_exprs:
| { [] }
| expr exprs               { $1 :: $2 }
;

exprs:
| { [] }
| COMMA expr exprs         { $2 :: $3 }
;

atom:
| UNIT           { Unit }
| INT            { Int ($1) }
| TRUE           { Bool (true) }
| FALSE          { Bool (false) }
| STRING         { String ($1) }
| IDENT          { Ident ($1) }
;
