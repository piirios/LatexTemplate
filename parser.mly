%{
    open Componantast ;;
%}

// artrithmetique
%token <int> INT 
%token <float> FLOAT 
%token <string> STRING 
%token <string> IDENT
%token PLUS MINUS MULT DIV EQUALEQUAL GREATER SMALLER GREATEREQUAL SMALLEREQUAL

// structure
%token LPAREN RPAREN
%token LSIMPLEBRACE RSIMPLEBRACE
%token LBRACKET RBRACKET
%token LDOUBLEBRACE RDOUBLEBRACE
%token LPARA RPARA
%token SEMICOLON
%token WHERE

// keywords
%token RETURN 
%token LET
%token FOR WHILE LOOP
%token IF ELSE ELSIF
%token TRUE FALSE

%start componant
%type <Componantast.componant> componant

%%

componant: IDENT LBRACKET params RBRACKET 

params:
| { [] }
| COMMA IDENT params { $2 :: $3 }