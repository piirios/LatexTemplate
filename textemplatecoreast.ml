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
  | Break
and instr = 
  | While of (expr * (instr list))
  | For of (string * expr * (instr list))
  | Loop of (instr list)
  | If of (expr * (instr list) * (instr list))
  | Assign of (string * expr)
  | Declare of (string * var_decl)
  | ArrayWrite of (string * expr * expr)
  | Return of (expr option)
  | Iapp of (string * (expr list))
  | Print of expr list
and var_decl =
  | Scalar of (expr*mutability) 
  | Array of ((expr list)*mutability)
and mutability = 
| Mutable
| Immutable
type fun_def = {
  f_name : string ;
  params : string list ;
  body : instr list
}


type top_level = 
  | Instruction of instr
  | Function of fun_def

type componant = {
  core: top_level list;
}

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
| Break -> Printf.fprintf oc "break"
and print_expr_opt oc = function
| None ->  Printf.fprintf oc "None"
| Some(e) ->  Printf.fprintf oc "Some("; print_expr oc e;  Printf.fprintf oc ")"

let rec print_expr_lst oc = function 
| [] -> Printf.fprintf oc "\n"
| hd::tl -> print_expr oc hd; print_expr_lst oc tl