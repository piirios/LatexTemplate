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