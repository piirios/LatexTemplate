%{
    open Ast ;;
%}

// tokens de base
%token EOF
%token <int> INT 
%token <float> FLOAT 
%token <string> STRING 
%token <string> IDENT
%token <string> TEMPLATE_STRING

// opérateurs arithmétiques
%token EQUALEQUAL COLONEQUAL PLUS MINUS MULT DIV GREATER SMALLER GREATEREQUAL SMALLEREQUAL

%left EQUALEQUAL GREATER SMALLER GREATEREQUAL SMALLEREQUAL
%left PLUS MINUS
%left MULT DIV

// structure
%token LPAREN RPAREN COMMA
%token LSIMPLEBRACE RSIMPLEBRACE
%token LBRACKET RBRACKET
%token SEMICOLON DOUBLEDOT UNIT

// mots-clés existants du lexer et balises de variables
%token TEMPLATE IF ELSE ELSIF ENDIF LOOP ENDLOOP FOR ENDFOR IN WHILE ENDWHILE TRUE FALSE BREAK USE
%token VAR_START VAR_END

%start template
%type <Ast.template list> template

%%

//template principal
template:
| TEMPLATE template_body TEMPLATE EOF { $2 }
;

template_body:
| { [] }
| template_element template_body { $1 :: $2 }
;

template_element:
| TEMPLATE_STRING { LatexContent $1 }
| IF expr template_body opt_else ENDIF
    { If ($2, $3, $4) }
| FOR IDENT IN expr template_body ENDFOR
    { For ($2, $4, $5) }
| WHILE expr template_body ENDWHILE
    { While ($2, $3) }
| LOOP template_body ENDLOOP
    { Loop $2 }
| USE IDENT LPAREN opt_exprs RPAREN 
    { Import ($2, $4) }
| BREAK 
    { Break }
| VAR_START expr VAR_END 
    { Expression $2 }
| IDENT 
    { Expression (Ident $1) }
;

opt_else:
| { [] }
| ELSE template_body { $2 }
;

//expressions
expr:
| expr EQUALEQUAL expr           { Binop ("==", $1, $3) }
| expr GREATER expr              { Binop (">", $1, $3) }
| expr GREATEREQUAL expr         { Binop (">=", $1, $3) }
| expr SMALLER expr              { Binop ("<", $1, $3) }
| expr SMALLEREQUAL expr         { Binop ("<=", $1, $3) }
| expr PLUS expr                 { Binop ("+", $1, $3) }
| expr MINUS expr                { Binop ("-", $1, $3) }
| expr MULT expr                 { Binop ("*", $1, $3) }
| expr DIV expr                  { Binop ("/", $1, $3) }
| expr DOUBLEDOT expr            { Range ($1, Some $3) }
| expr DOUBLEDOT                 { Range ($1, None) }
| MINUS expr                     { Monop ("-", $2) }
| LPAREN expr RPAREN             { $2 }
| atom                           { $1 }
| IDENT LPAREN opt_exprs RPAREN  { App ($1, $3) }
;

opt_exprs:
| { [] }
| expr { [$1] }
| expr COMMA opt_exprs { $1 :: $3 }
;

atom:
| INT            { Int ($1) }
| STRING         { String ($1) }
| IDENT          { Ident ($1) }
| TRUE           { Bool true }
| FALSE          { Bool false }
| UNIT           { Unit }
;
