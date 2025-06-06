(* Table de hachage pour stocker les définitions de fonctions *)
let init_functions_table fnum = 
    Hashtbl.create fnum

(* fonction pour charger toutes les fonctions dans un table de hachage et retourner ce qu'il y a d'autre dans le toplevel
 ce choix est motivé par le fait que les fonctions sont définies que dans le toplevel, qui est entierement connue et invariant lors de l'execution
*)
let load_function_into_table tbl tplvls =
    let rec load_function_into_table_rec acc = function
        | [] -> acc
        | Ast.Function(func) :: tl -> 
            let sub_tbl = Hashtbl.create (List.length func.params) in
            List.iteri (fun i param -> 
                Hashtbl.add sub_tbl param (Ast.Ident("_" ^ param ^ "_" ^ func.f_name))
            ) func.params;
            let renamed_func = {
                func with
                body = Subst.alpha_substitution sub_tbl func.body
            } in
            Hashtbl.add tbl func.f_name renamed_func;
            load_function_into_table_rec acc tl
        | hd :: tl -> load_function_into_table_rec (hd :: acc) tl
    in
    load_function_into_table_rec [] tplvls