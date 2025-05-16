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