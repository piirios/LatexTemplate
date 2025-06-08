%{
    open Ast ;;
%}

// tokens de base
%token EOF
%token <int> INT 
%token <float> FLOAT 
%token <string> STRING 
%token <string> IDENT
%token <string> IMPORT_PATH
%token <string> TEMPLATE_STRING

// opérateurs arithmétiques
%token EQUALEQUAL COLONEQUAL PLUS MINUS MULT DIV MOD GREATER SMALLER GREATEREQUAL SMALLEREQUAL NOT NOTEQUAL AND OR

%left EQUALEQUAL NOTEQUAL GREATER SMALLER GREATEREQUAL SMALLEREQUAL
%left OR
%left AND
%left PLUS MINUS
%left MULT DIV MOD

// structure
%token LPAREN RPAREN COMMA
%token LSIMPLEBRACE RSIMPLEBRACE
%token LBRACKET RBRACKET
%token SEMICOLON DOUBLEDOT UNIT

// mots-clés pour le core
%token LET RETURN PRINT FOR WHILE LOOP IN IF ELSE ELSIF TRUE FALSE BREAK FN

// mots-clés pour template
%token TEMPLATE ENDIF ENDLOOP ENDFOR ENDWHILE USE
%token TEMPLATE_START TEMPLATE_END
%token VAR_START VAR_END

%start componants
%type <Ast.top_level list> componants

%%

componants:
| EOF { [] }
| toplevel componants { $1 :: $2 }
;

opt_params:
| { [] }
| IDENT params { $1 :: $2 }
;

params:
| { [] }
| COMMA IDENT params { $2 :: $3 }
;

// Core language body
core_body:
| { [] }
| toplevel core_body { $1 :: $2 }
;

toplevel:
| expr SEMICOLON { Expression $1 }
| instr { Instruction $1 }
| fun_def { Function $1 }
| USE IDENT SEMICOLON { Import $2 }
| USE IMPORT_PATH SEMICOLON { Import $2 }
;

// Function definition
fun_def:
| FN IDENT LPAREN opt_params RPAREN instr_scope
    { { f_name = $2 ; params = $4 ; body = $6 } }
;

// Variable declaration
var_decl_content:
| LET IDENT COLONEQUAL expr { Declare ($2, Scalar $4) }
| LET IDENT COLONEQUAL LBRACKET exprs RBRACKET { Declare ($2, Array $5) }
;

// Instructions
instrs:
| instr { [$1] }
| instr instrs { $1 :: $2 }
;

instr_scope:
| LSIMPLEBRACE instrs RSIMPLEBRACE { $2 }
;

instr:
| IF expr instr_scope ELSE instr_scope
    { If ($2, $3, $5) }
| IF expr instr_scope
    { If ($2, $3, []) }
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

// Template parsing
template:
| TEMPLATE_START template_body TEMPLATE_END { $2 }
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
| expr 
    { Expression $1 }
| IDENT 
    { Expression (Ident $1) }
;

opt_else:
| { [] }
| ELSE template_body { $2 }
;

// Expressions
expr:
| expr EQUALEQUAL expr           { Binop ("==", $1, $3) }
| expr NOTEQUAL expr             { Binop ("!=", $1, $3) }
| expr GREATER expr              { Binop (">", $1, $3) }
| expr GREATEREQUAL expr         { Binop (">=", $1, $3) }
| expr SMALLER expr              { Binop ("<", $1, $3) }
| expr SMALLEREQUAL expr         { Binop ("<=", $1, $3) }
| expr AND expr                  { Binop ("&&", $1, $3) }
| expr OR expr                   { Binop ("||", $1, $3) }
| expr PLUS expr                 { Binop ("+", $1, $3) }
| expr MINUS expr                { Binop ("-", $1, $3) }
| expr MULT expr                 { Binop ("*", $1, $3) }
| expr DIV expr                  { Binop ("/", $1, $3) }
| expr MOD expr                  { Binop ("%", $1, $3) }
| expr DOUBLEDOT expr            { Range ($1, Some $3) }
| expr DOUBLEDOT                 { Range ($1, None) }
| MINUS expr                     { Monop ("-", $2) }
| NOT expr                       { Monop ("!", $2) }
| LPAREN expr RPAREN             { $2 }
| atom                           { $1 }
| IDENT LPAREN opt_exprs RPAREN  { App ($1, $3) }
| IDENT LBRACKET expr RBRACKET   { ArrayRead ($1, $3) }
| template                       { Template ($1) }
;

opt_exprs:
| { [] }
| expr { [$1] }
| expr COMMA opt_exprs { $1 :: $3 }
;

opt_expr:
| { Unit }
| expr { $1 }
;

exprs:
| { [] }
| COMMA expr exprs { $2 :: $3 }
;

atom:
| INT            { Int ($1) }
| STRING         { String ($1) }
| IDENT          { Ident ($1) }
| TRUE           { Bool true }
| FALSE          { Bool false }
| UNIT           { Unit }
;