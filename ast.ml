(* ////////// Type definition //////////*) 
type expr =
  | Int of int
  | Bool of bool
  | String of string
  | Ident of string
  | ArrayRead of (string * expr)
  | App of (string * (expr list))
  | Monop of (string * expr)
  | Binop of (string * expr * expr)
  | Range of (expr * expr option)
  | Unit
  | Template of (template list)
and instr = 
  | While of (expr * (instr list))
  | For of (string * expr * (instr list))
  | Loop of (instr list)
  | If of (expr * (instr list) * (instr list))
  | Assign of (string * expr)
  | Declare of (string * mutability * var_decl)
  | ArrayWrite of (string * expr * expr)
  | Return of expr
  | Iapp of (string * (expr list))
  | Print of expr list
  | Break
and var_decl =
  | Scalar of expr 
  | Array of expr list
and mutability = 
| Mutable
| Immutable
and template = 
| LatexContent of string 
| Expression of expr
| For of (string * expr * (template list))
| While of (expr * (template list))
| Loop of (template list)
| If of (expr * (template list) * (template list))
| Import of (string * (expr list))
| Break
type fun_def = {
  f_name : string ;
  params : string list ;
  body : instr list
}


type top_level = 
  | Instruction of instr
  | Expression of expr
  | Function of fun_def
  | Import of string



(* ////////// PRINT //////////*) 

(* Forward declarations for mutually recursive print functions *) 
let rec print_expr oc = function 
| Int (i) -> Printf.fprintf oc "%d" i
| Bool (b) -> Printf.fprintf oc "%s" (if b then "true" else "false")
| String (s) -> Printf.fprintf oc "\"%s\"" s
| Ident (s) -> Printf.fprintf oc "%s" s
| ArrayRead(name, i) -> Printf.fprintf oc "%s[" name; print_expr oc i; Printf.fprintf oc "]"
| App(fname, expr_lst) -> Printf.fprintf oc "%s(" fname; begin match expr_lst with 
    | [] -> ()
    | hd::tl -> print_expr oc hd; List.iter (fun expr -> Printf.fprintf oc ","; print_expr oc expr) tl
  end; Printf.fprintf oc ")"
| Binop (op, e1, e2) ->
      Printf.fprintf oc "(%a %s %a)" print_expr e1 op print_expr e2
| Monop (op, e) -> Printf.fprintf oc "%s%a" op print_expr e
| Range(start_range, end_range) -> print_expr oc start_range; Printf.fprintf oc ".."; print_expr_opt oc end_range
| Unit -> Printf.fprintf oc "()"
| Template (tl) -> Printf.fprintf oc "<%% template %a %%>" print_template_list tl
and print_expr_opt oc = function
| None ->  Printf.fprintf oc "None"
| Some(e) ->  Printf.fprintf oc "Some("; print_expr oc e;  Printf.fprintf oc ")"
and print_template oc = function
| LatexContent s -> Printf.fprintf oc "%s" s
| Expression e -> Printf.fprintf oc "<%% %a %%>" print_expr e
| For (var, expr, body) -> Printf.fprintf oc "<%% for %s in %a %%>\n%a<%% endfor %%>" var print_expr expr print_template_list body
| While (expr, body) -> Printf.fprintf oc "<%% while %a %%>\n%a<%% endwhile %%>" print_expr expr print_template_list body
| Loop body -> Printf.fprintf oc "<%% loop %%>\n%a<%% endloop %%>" print_template_list body
| If (cond, then_body, else_body) -> 
    Printf.fprintf oc "<%% if %a %%>\n%a" print_expr cond print_template_list then_body;
    (match else_body with [] -> () | _ -> Printf.fprintf oc "<%% else %%>\n%a" print_template_list else_body);
    Printf.fprintf oc "<%% endif %%>"
| Import (fname, args) -> 
    Printf.fprintf oc "<%% import %s(" fname;
    (match args with 
    | [] -> ()
    | hd::tl -> print_expr oc hd; List.iter (fun expr -> Printf.fprintf oc ","; print_expr oc expr) tl);
    Printf.fprintf oc ") %%>"
| Break -> Printf.fprintf oc "<%% break %%>"
and print_template_list oc tl =
  List.iter (print_template oc) tl

let rec print_expr_lst oc = function 
| [] -> Printf.fprintf oc "\n"
| hd::tl -> print_expr oc hd;Printf.fprintf oc "\n"; print_expr_lst oc tl

(* instruction *)
and print_inst oc = function
| Break -> Printf.fprintf oc "break;"
| While (cond, body) -> 
    Printf.fprintf oc "while %a {\n%a}\n" print_expr cond print_inst_list body
| For (var, expr, body) -> 
    Printf.fprintf oc "for %s in %a {\n%a}\n" var print_expr expr print_inst_list body
| Loop body -> 
    Printf.fprintf oc "loop {\n%a}\n" print_inst_list body
| If (cond, then_body, else_body) -> 
    Printf.fprintf oc "if %a {\n%a} else {\n%a}\n" 
      print_expr cond 
      print_inst_list then_body 
      print_inst_list else_body
| Assign (var, expr) -> 
    Printf.fprintf oc "%s = %a;\n" var print_expr expr
| Declare (var,mut,decl) -> 
    Printf.fprintf oc "let %s = %a;\n" var (fun oc -> function
      | Scalar (expr) -> 
          Printf.fprintf oc "%s%a" (if mut = Mutable then "mut " else "") print_expr expr
      | Array (exprs) -> 
          Printf.fprintf oc "%s[%a]" (if mut = Mutable then "mut " else "") 
            (fun oc e_lst -> 
              match e_lst with 
              | [] -> ()
              | hd::tl -> print_expr oc hd; List.iter (fun e -> Printf.fprintf oc ", %a" print_expr e) tl
            ) exprs
    ) decl
| ArrayWrite (arr, idx, expr) -> 
    Printf.fprintf oc "%s[%a] = %a;\n" arr print_expr idx print_expr expr
| Return expr -> 
    Printf.fprintf oc "return %a;\n" print_expr expr
| Iapp (fname, args) -> 
    Printf.fprintf oc "%s(" fname;
    (match args with 
    | [] -> ()
    | hd::tl -> print_expr oc hd; List.iter (fun expr -> Printf.fprintf oc ", %a" print_expr expr) tl);
    Printf.fprintf oc ");\n"
| Print exprs -> 
    Printf.fprintf oc "print(";
    (match exprs with 
    | [] -> ()
    | hd::tl -> print_expr oc hd; List.iter (fun e -> Printf.fprintf oc ", %a" print_expr e) tl);
    Printf.fprintf oc ");\n"

and print_inst_list oc = function
| [] -> ()
| hd::tl -> print_inst oc hd; print_inst_list oc tl

(* top level *)
let print_toplevel oc = function 
| Instruction(inst) -> print_inst oc inst;
| Expression(expr) ->  print_expr oc expr
| Import(fname) -> Printf.fprintf oc "import %s;\n" fname
| Function(func) ->  
    Printf.fprintf oc "function %s(%s) {\n%a}\n" 
      func.f_name 
      (String.concat ", " func.params)
      print_inst_list func.body
;;

let rec print_toplevel_lst oc = function 
| [] -> Printf.fprintf oc "\n"
| hd::tl -> print_toplevel oc hd;Printf.fprintf oc "\n"; print_toplevel_lst oc tl
;;

let print_componant oc comp = 
  print_toplevel_lst oc comp
;;

(* ////////// DEBUG PRINT (dbg! style) //////////*)

let rec print_dbg_list_g start_char end_char sep_string print_item oc = function
  | [] -> Printf.fprintf oc "%c%c" start_char end_char
  | hd :: tl ->
    Printf.fprintf oc "%c" start_char;
    print_item oc hd;
    List.iter (fun item -> Printf.fprintf oc "%s" sep_string; print_item oc item) tl;
    Printf.fprintf oc "%c" end_char

let print_dbg_string_list oc sl =
  print_dbg_list_g '[' ']' "; " (fun o s -> Printf.fprintf o "\"%s\"" s) oc sl

(* Start of the mutually recursive block for dbg printers *)
let rec print_dbg_expr_list oc el =
  print_dbg_list_g '[' ']' "; " print_dbg_expr oc el

and print_dbg_expr_option oc eo =
  match eo with
  | None -> Printf.fprintf oc "None"
  | Some e -> Printf.fprintf oc "Some(%a)" print_dbg_expr e

and print_dbg_expr oc = function
  | Int i -> Printf.fprintf oc "Int(%d)" i
  | Bool b -> Printf.fprintf oc "Bool(%b)" b
  | String s -> Printf.fprintf oc "String(\"%s\")" (String.escaped s)
  | Ident s -> Printf.fprintf oc "Ident(\"%s\")" s
  | ArrayRead (name, idx) -> Printf.fprintf oc "ArrayRead(\"%s\", %a)" name print_dbg_expr idx
  | App (fname, expr_lst) -> Printf.fprintf oc "App(\"%s\", %a)" fname print_dbg_expr_list expr_lst
  | Monop (op, e) -> Printf.fprintf oc "Monop(\"%s\", %a)" op print_dbg_expr e
  | Binop (op, e1, e2) -> Printf.fprintf oc "Binop(\"%s\", %a, %a)" op print_dbg_expr e1 print_dbg_expr e2
  | Range (e1, e2_opt) -> Printf.fprintf oc "Range(%a, %a)" print_dbg_expr e1 print_dbg_expr_option e2_opt
  | Unit -> Printf.fprintf oc "Unit"
  | Template tl -> Printf.fprintf oc "Template(%a)" print_dbg_template_list tl

and print_dbg_mutability oc = function
  | Mutable -> Printf.fprintf oc "Mutable"
  | Immutable -> Printf.fprintf oc "Immutable"

and print_dbg_var_decl oc = function
  | Scalar e -> Printf.fprintf oc "Scalar(%a)" print_dbg_expr e
  | Array el -> Printf.fprintf oc "Array(%a)" print_dbg_expr_list el

and print_dbg_instr_list oc il =
  print_dbg_list_g '[' ']' "; " print_dbg_instr oc il

and print_dbg_instr oc = function
  | While (e, il) -> Printf.fprintf oc "While(%a, %a)" print_dbg_expr e print_dbg_instr_list il
  | For (s, e, il) -> Printf.fprintf oc "For(\"%s\", %a, %a)" s print_dbg_expr e print_dbg_instr_list il
  | Loop il -> Printf.fprintf oc "Loop(%a)" print_dbg_instr_list il
  | If (e, il1, il2) -> Printf.fprintf oc "If(%a, %a, %a)" print_dbg_expr e print_dbg_instr_list il1 print_dbg_instr_list il2
  | Assign (s, e) -> Printf.fprintf oc "Assign(\"%s\", %a)" s print_dbg_expr e
  | Declare (s, m, vd) -> Printf.fprintf oc "Declare(\"%s\", %a, %a)" s print_dbg_mutability m print_dbg_var_decl vd
  | ArrayWrite (s, e1, e2) -> Printf.fprintf oc "ArrayWrite(\"%s\", %a, %a)" s print_dbg_expr e1 print_dbg_expr e2
  | Return e -> Printf.fprintf oc "Return(%a)" print_dbg_expr e
  | Iapp (s, el) -> Printf.fprintf oc "Iapp(\"%s\", %a)" s print_dbg_expr_list el
  | Print el -> Printf.fprintf oc "Print(%a)" print_dbg_expr_list el
  | Break -> Printf.fprintf oc "Break" (* Instruction Break *)

and print_dbg_template_list oc tl =
  print_dbg_list_g '[' ']' "; " print_dbg_template oc tl
  
and print_dbg_template oc = function
  | LatexContent s -> Printf.fprintf oc "LatexContent(\"%s\")" (String.escaped s)
  | Expression e -> Printf.fprintf oc "Expression(%a)" print_dbg_expr e
  | For (s, e, tl) -> Printf.fprintf oc "For(\"%s\", %a, %a)" s print_dbg_expr e print_dbg_template_list tl
  | While (e, tl) -> Printf.fprintf oc "While(%a, %a)" print_dbg_expr e print_dbg_template_list tl
  | Loop tl -> Printf.fprintf oc "Loop(%a)" print_dbg_template_list tl
  | If (e, tl1, tl2) -> Printf.fprintf oc "If(%a, %a, %a)" print_dbg_expr e print_dbg_template_list tl1 print_dbg_template_list tl2
  | Import (s, el) -> Printf.fprintf oc "Import(\"%s\", %a)" s print_dbg_expr_list el
  | Break -> Printf.fprintf oc "Break" (* Template Break *)

(* End of the mutually recursive block *)

let print_dbg_fun_def oc (fd : fun_def) =
  Printf.fprintf oc "FunDef { f_name = \"%s\"; params = %a; body = %a }"
    fd.f_name
    print_dbg_string_list fd.params
    print_dbg_instr_list fd.body

let print_dbg_top_level oc = function
  | Instruction i -> Printf.fprintf oc "Instruction(%a)" print_dbg_instr i
  | Expression e -> Printf.fprintf oc "Expression(%a)" print_dbg_expr e
  | Function fd -> Printf.fprintf oc "Function(%a)" print_dbg_fun_def fd
  | Import fname -> Printf.fprintf oc "Import(%s)" fname

let print_dbg_top_level_list oc tll =
  print_dbg_list_g '[' ']' ";\\n" print_dbg_top_level oc tll
;;