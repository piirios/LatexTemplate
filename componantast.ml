type expr =
  | Int of int
  | Bool of bool
  | String of string
  | Ident of string
  | ArrayRead of (string * expr)
  | App of (string * (expr list))
  | Monop of (string * expr)
  | Binop of (string * expr * expr)
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
  | Scalar of expr 
  | Array of expr list


type latexTemplate = 
  | Latex of string
  | Ident of string
  | For of (string*expr*(latexTemplate list)) (* iterator over, iterator on, main *)
  | Cond of (expr*(latexTemplate list)*(latexTemplate list))

type fun_def = {
  f_name : string ;
  params : string list ;
  body : instr list
}

type top_level = 
  | Instruction of instr
  | Function of fun_def

type componant = {
  name: string;
  args: string list;
  core: top_level list;
  template: latexTemplate list;
  where: expr list
}