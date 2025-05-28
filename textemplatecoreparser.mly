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
%token COLONEQUAL UNIT PLUS MINUS MULT DIV EQUALEQUAL GREATER SMALLER GREATEREQUAL SMALLEREQUAL

%left EQUAL EQUALEQUAL GREATER SMALLER GREATEREQUAL SMALLEREQUAL
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
%token LET MUT
%token PRINT
%token FOR WHILE LOOP IN
%token IF ELSE ELSIF
%token TRUE FALSE
%token BREAK
%token FN

//template
%token OPENTEMPLATE
%token CLOSETEMPLATE

%start componant
%type <Textemplatecoreast.componant> componant

%%

//toplevel
componant:
| toplevel_lst { {core= $1} }
;

toplevel_lst:
| EOF { [] }
| toplevel toplevel_lst { $1 :: $2 }
;

toplevel:
| expr SEMICOLON { Expression $1 }
| instr { Instruction $1 }
| fun_def { Function $1 }
;

//function

fun_def:
| FN IDENT LPAREN opt_params RPAREN instr_scope
    { { f_name = $2 ; params = $4 ; body = $6 } }
;

opt_params:
| { [] }
| IDENT params { $1 :: $2 }
;

params:
| { [] }
| COMMA IDENT params { $2 :: $3 }
;

//variable decl

var_decl_content:
| LET IDENT COLONEQUAL expr { Declare ($2, Immutable, Scalar $4) }
| LET MUT IDENT COLONEQUAL expr { Declare ($3, Mutable, Scalar $5) }
| LET IDENT COLONEQUAL LBRACKET exprs RBRACKET { Declare ($2, Immutable, Array $5) }
| LET MUT IDENT COLONEQUAL LBRACKET exprs RBRACKET { Declare ($3, Mutable, Array $6) }
;

//instruction

instrs:
| instr { [$1] }
| instr instrs { $1 :: $2 }
;

instr_scope:
| LSIMPLEBRACE instrs RSIMPLEBRACE { $2 }

instr:
| IF expr instr_scope ELSE instr_scope
    { If ($2, $3, $5) }
| WHILE expr instr_scope
    { While ($2, $3) }
| LOOP instr_scope
    { Loop ($2) }
| FOR IDENT IN expr instr_scope
    { For ($2, $4, $5) }
| var_decl_content SEMICOLON { $1 }
| IDENT COLONEQUAL expr SEMICOLON
    { Assign ($1, $3) }
| IDENT LBRACKET expr RBRACKET COLONEQUAL expr SEMICOLON
    { ArrayWrite ($1, $3, $6) }
| RETURN opt_expr SEMICOLON
    { Return $2 }
| IDENT LPAREN opt_exprs RPAREN SEMICOLON
    { Iapp ($1, $3) }
| PRINT LPAREN opt_exprs RPAREN SEMICOLON
    { Print $3 }
| BREAK SEMICOLON
    { Break }
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
| expr DOUBLEDOT expr            { Range ($1, Some $3) }
| expr DOUBLEDOT                 { Range ($1, None) }
;

opt_exprs:
| { [] }
| expr { [$1] }
| expr COMMA opt_exprs               { $1 :: $3 }
;

opt_expr:
| { Unit }
| expr               { $1 }
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

// Switch to Latex Mode
template:
| OPENTEMPLATE template_core CLOSETEMPLATE { $2 }

template_core: 
| 