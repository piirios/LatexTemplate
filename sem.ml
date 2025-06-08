(* type pour ce que peut produire une expression *)
type code_val = 
| Vint of int
| Vbool of bool
| Vstring of string
| Varray of code_val list
| Vrange of int * int option
| Vtemplate of string
| Vunit

(* type pour les les expressions incorporables dans un template *)
type template_val = 
| Tint of int
| Tbool of bool
| Tstring of string
| Tunit

type env = (string, code_val) Hashtbl.t

(* Exceptions pour le contrôle de flux *)
exception Break_exception
exception Return_exception of code_val

let init_env () = Hashtbl.create 100

let add_to_env env var val_ = Hashtbl.add env var val_

let get_from_env env var = Hashtbl.find env var

(* fonction pour produire la string de la valeur incorporable *)
let produce_string = function
| Tint i -> string_of_int i
| Tbool b -> string_of_bool b
| Tstring s -> s
| Tunit -> ""

(* fonction pour produire les expressions incorporables dans un template a partir d'une valeur d'une expression *)
let produce_template_val = function
| Vint i -> Tint i
| Vbool b -> Tbool b
| Vstring s -> Tstring s
| Vunit -> Tunit
| Varray _ -> raise (Exception_content.Type_error (Exception_content.make_type_error "type simple" "array" "conversion vers template"))
| Vrange _ -> raise (Exception_content.Type_error (Exception_content.make_type_error "type simple" "range" "conversion vers template"))
| Vtemplate tpl -> Tstring tpl

(* Fonction next pour les itérateurs *)
let next = function
| Vrange (current, None) -> 
    (* Range infini : retourne current et current+1.. *)
    (Some (Vint current), Vrange (current + 1, None))
| Vrange (current, Some end_val) when current <= end_val -> 
    (* Range fini avec éléments restants *)
    (Some (Vint current), Vrange (current + 1, Some end_val))
| Vrange (_, Some _) -> 
    (* Range épuisé *)
    (None, Vrange (0, Some (-1))) (* Range vide *)
| Varray (hd :: tl) ->
    (* Tableau avec éléments : retourne le premier et le reste *)
    (Some hd, Varray tl)
| Varray [] ->
    (* Tableau vide *)
    (None, Varray [])
| _ -> raise (Exception_content.Type_error (Exception_content.make_type_error "Vrange ou Varray" "autre type" "fonction next pour itération"))

(* Fonctions d'évaluation des opérateurs *)
let eval_binop op v1 v2 = 
  let get_type_name = function
    | Vint _ -> "int"
    | Vbool _ -> "bool" 
    | Vstring _ -> "string"
    | Varray _ -> "array"
    | Vrange _ -> "range"
    | Vtemplate _ -> "template"
    | Vunit -> "unit"
  in
  match op, v1, v2 with
  | "+", Vint i1, Vint i2 -> Vint (i1 + i2)
  | "-", Vint i1, Vint i2 -> Vint (i1 - i2)
  | "*", Vint i1, Vint i2 -> Vint (i1 * i2)
  | "/", Vint i1, Vint i2 -> 
      if i2 = 0 then raise (Exception_content.Division_error (Exception_content.make_division_error "/" "opération binaire"))
      else Vint (i1 / i2)
  | "%", Vint i1, Vint i2 -> 
      if i2 = 0 then raise (Exception_content.Division_error (Exception_content.make_division_error "%" "opération binaire"))
      else Vint (i1 mod i2)
  | "==", v1, v2 -> Vbool (v1 = v2)
  | "!=", v1, v2 -> Vbool (v1 <> v2)
  | "<", Vint i1, Vint i2 -> Vbool (i1 < i2)
  | "<=", Vint i1, Vint i2 -> Vbool (i1 <= i2)
  | ">", Vint i1, Vint i2 -> Vbool (i1 > i2)
  | ">=", Vint i1, Vint i2 -> Vbool (i1 >= i2)
  | "&&", Vbool b1, Vbool b2 -> Vbool (b1 && b2)
  | "||", Vbool b1, Vbool b2 -> Vbool (b1 || b2)
  | "+", Vstring s1, Vstring s2 -> Vstring (s1 ^ s2)
  | _ -> raise (Exception_content.Operator_error (Exception_content.make_operator_error op (get_type_name v1) (Some (get_type_name v2)) "évaluation d'expression binaire"))

let eval_monop op v = 
  let get_type_name = function
    | Vint _ -> "int"
    | Vbool _ -> "bool" 
    | Vstring _ -> "string"
    | Varray _ -> "array"
    | Vrange _ -> "range"
    | Vtemplate _ -> "template"
    | Vunit -> "unit"
  in
  match op, v with
  | "-", Vint i -> Vint (-i)
  | "!", Vbool b -> Vbool (not b)
  | _ -> raise (Exception_content.Operator_error (Exception_content.make_operator_error op (get_type_name v) None "évaluation d'expression unaire"))

let rec eval_expr env fun_tbl expr = 
  match expr with
  | Ast.Int i -> Vint i
  | Ast.Bool b -> Vbool b
  | Ast.String s -> Vstring s
  | Ast.Unit -> Vunit
  | Ast.Ident var -> 
      (try get_from_env env var
       with Not_found -> raise (Exception_content.Undefined_variable (Exception_content.make_undefined_variable var "évaluation d'expression")))
  | Ast.ArrayRead (arr_name, idx_expr) ->
      let arr_val = (try get_from_env env arr_name 
                     with Not_found -> raise (Exception_content.Undefined_variable (Exception_content.make_undefined_variable arr_name "lecture de tableau"))) in
      let idx_val = eval_expr env fun_tbl idx_expr in
      (match arr_val, idx_val with
       | Varray arr, Vint i -> 
           if i >= 0 && i < List.length arr then
             List.nth arr i
           else raise (Exception_content.Array_index_error (Exception_content.make_array_index_error arr_name i (List.length arr) "lecture de tableau"))
       | _, Vint _ -> raise (Exception_content.Type_error (Exception_content.make_type_error "array" "autre type" ("lecture de " ^ arr_name)))
       | _, _ -> raise (Exception_content.Type_error (Exception_content.make_type_error "int" "autre type" ("index de " ^ arr_name))))
  | Ast.App (fname, args) ->
      let arg_vals = List.map (eval_expr env fun_tbl) args in
      (try 
         let func_def = Hashtbl.find fun_tbl fname in
         let new_env = init_env () in
         List.iter2 (add_to_env new_env) func_def.Ast.params (List.map (fun v -> v) arg_vals);
         try
           List.iter (eval_instr new_env fun_tbl) func_def.Ast.body;
           Vunit (* Si aucun return explicite *)
         with Return_exception result -> result
       with Not_found -> 
         let available_funcs = Hashtbl.fold (fun k _ acc -> k :: acc) fun_tbl [] in
         raise (Exception_content.Undefined_function (Exception_content.make_undefined_function fname available_funcs)))
  | Ast.Binop (op, e1, e2) ->
      let v1 = eval_expr env fun_tbl e1 in
      let v2 = eval_expr env fun_tbl e2 in
      eval_binop op v1 v2
  | Ast.Monop (op, e) ->
      let v = eval_expr env fun_tbl e in
      eval_monop op v
  | Ast.Range (start_expr, end_expr_opt) ->
      let start_val = eval_expr env fun_tbl start_expr in
      let end_val_opt = match end_expr_opt with
        | None -> None
        | Some e -> Some (eval_expr env fun_tbl e) in
      (match start_val, end_val_opt with
       | Vint start, None -> Vrange (start, None)
       | Vint start, Some (Vint end_val) -> Vrange (start, Some end_val)
       | Vint _, Some _ -> raise (Exception_content.Type_error (Exception_content.make_type_error "int" "autre type" "borne de fin de range"))
       | _, _ -> raise (Exception_content.Type_error (Exception_content.make_type_error "int" "autre type" "borne de début de range")))
  | Ast.Template tpl_list ->
      let tpl_content = eval_template_val env fun_tbl tpl_list in
      Vtemplate tpl_content

and eval_template_val env fun_tbl tpl_list =
  let eval_single_template tpl = 
    match tpl with
    | Ast.LatexContent s -> s
    | Ast.Expression e -> 
        let val_result = eval_expr env fun_tbl e in
        produce_string (produce_template_val val_result)
    | Ast.For (var, range_expr, body) ->
        let iterable_val = eval_expr env fun_tbl range_expr in
        let rec iter_loop acc current_iter =
          match next current_iter with
          | None, _ -> acc
          | Some element, new_iter ->
              let new_env = Hashtbl.copy env in
              add_to_env new_env var element;
              try
                let body_result = eval_template_val new_env fun_tbl body in
                iter_loop (acc ^ body_result) new_iter
              with Break_exception -> acc
        in
        iter_loop "" iterable_val
    | Ast.While (cond_expr, body) ->
        let rec while_loop acc =
          let cond_val = eval_expr env fun_tbl cond_expr in
          match cond_val with
          | Vbool true -> 
              (try
                 let body_result = eval_template_val env fun_tbl body in
                 while_loop (acc ^ body_result)
               with Break_exception -> acc)
          | Vbool false -> acc
          | _ -> raise (Exception_content.Type_error (Exception_content.make_type_error "bool" "autre type" "condition while dans template")) in
        while_loop ""
    | Ast.Loop body ->
        let rec infinite_loop acc =
          try
            let body_result = eval_template_val env fun_tbl body in
            infinite_loop (acc ^ body_result)
          with Break_exception -> acc in
        infinite_loop ""
    | Ast.If (cond_expr, then_body, else_body) ->
        let cond_val = eval_expr env fun_tbl cond_expr in
        (match cond_val with
         | Vbool true -> eval_template_val env fun_tbl then_body
         | Vbool false -> eval_template_val env fun_tbl else_body
         | _ -> raise (Exception_content.Type_error (Exception_content.make_type_error "bool" "autre type" "condition if dans template")))
    | Ast.Import (fname, args) ->
        (* Appel de fonction pour les imports *)
        let result = eval_expr env fun_tbl (Ast.App (fname, args)) in
        (match result with
         | Vtemplate template_content -> template_content
         | _ -> raise (Exception_content.Template_error (Exception_content.make_template_error fname "doit retourner un template" "import dans template")))
    | Ast.Break -> raise Break_exception
  in
  String.concat "" (List.map eval_single_template tpl_list)

and eval_instr env fun_tbl instr = 
  match instr with
  | Ast.Break -> raise Break_exception
  | Ast.While (cond_expr, body) ->
      let rec while_loop () =
        let cond_val = eval_expr env fun_tbl cond_expr in
        match cond_val with
        | Vbool true -> 
            (try
               List.iter (eval_instr env fun_tbl) body;
               while_loop ()
             with Break_exception -> ())
        | Vbool false -> ()
        | _ -> raise (Exception_content.Type_error (Exception_content.make_type_error "bool" "autre type" "condition while")) in
      while_loop ()
  | Ast.For (var, range_expr, body) ->
      let iterable_val = eval_expr env fun_tbl range_expr in
      let rec iter_loop current_iter =
        match next current_iter with
        | None, _ -> ()
        | Some element, new_iter ->
            let new_env = Hashtbl.copy env in
            add_to_env new_env var element;
            (try
               List.iter (eval_instr new_env fun_tbl) body;
               iter_loop new_iter
             with Break_exception -> ())
      in
      iter_loop iterable_val
  | Ast.Loop body ->
      let rec infinite_loop () =
        try
          List.iter (eval_instr env fun_tbl) body;
          infinite_loop ()
        with Break_exception -> () in
      infinite_loop ()
  | Ast.If (cond_expr, then_body, else_body) ->
      let cond_val = eval_expr env fun_tbl cond_expr in
      (match cond_val with
       | Vbool true -> List.iter (eval_instr env fun_tbl) then_body
       | Vbool false -> List.iter (eval_instr env fun_tbl) else_body
       | _ -> raise (Exception_content.Type_error (Exception_content.make_type_error "bool" "autre type" "condition if")))
  | Ast.Assign (var, expr) ->
      let val_result = eval_expr env fun_tbl expr in
      Hashtbl.replace env var val_result
  | Ast.Declare (var, mutability, var_decl) ->
      (match var_decl with
       | Ast.Scalar expr -> 
           let val_result = eval_expr env fun_tbl expr in
           add_to_env env var val_result
       | Ast.Array expr_list ->
           let val_list = List.map (eval_expr env fun_tbl) expr_list in
           add_to_env env var (Varray val_list))
  | Ast.ArrayWrite (arr_name, idx_expr, val_expr) ->
      let idx_val = eval_expr env fun_tbl idx_expr in
      let new_val = eval_expr env fun_tbl val_expr in
      let arr_val = (try get_from_env env arr_name 
                     with Not_found -> raise (Exception_content.Undefined_variable (Exception_content.make_undefined_variable arr_name "écriture de tableau"))) in
      (match arr_val, idx_val with
       | Varray arr, Vint i -> 
           if i >= 0 && i < List.length arr then
             let new_arr = List.mapi (fun j code_val -> 
               if j = i then new_val else code_val
             ) arr in
             Hashtbl.replace env arr_name (Varray new_arr)
           else raise (Exception_content.Array_index_error (Exception_content.make_array_index_error arr_name i (List.length arr) "écriture de tableau"))
       | _, Vint _ -> raise (Exception_content.Type_error (Exception_content.make_type_error "array" "autre type" ("écriture dans " ^ arr_name)))
       | _, _ -> raise (Exception_content.Type_error (Exception_content.make_type_error "int" "autre type" ("index pour écriture dans " ^ arr_name))))
  | Ast.Return expr ->
      let val_result = eval_expr env fun_tbl expr in
      raise (Return_exception val_result)
  | Ast.Iapp (fname, args) ->
      let _ = eval_expr env fun_tbl (Ast.App (fname, args)) in
      () (* Ignore le résultat pour les appels d'instruction *)
  | Ast.Print expr_list ->
      List.iter (fun e ->
        let val_result = eval_expr env fun_tbl e in
        let output = match val_result with
          | Vint i -> string_of_int i
          | Vbool b -> string_of_bool b
          | Vstring s -> s
          | Vunit -> "()"
          | Varray arr -> 
              "[" ^ String.concat "; " (List.map (fun v -> match v with
                | Vint i -> string_of_int i
                | Vbool b -> string_of_bool b
                | Vstring s -> "\"" ^ s ^ "\""
                | Vunit -> "()"
                | _ -> "..."
              ) arr) ^ "]"
          | Vrange (start, None) -> string_of_int start ^ ".."
          | Vrange (start, Some end_val) -> string_of_int start ^ ".." ^ string_of_int end_val
          | Vtemplate s -> s in
        print_string output; print_newline ()
      ) expr_list 