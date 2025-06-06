(* Table de hachage pour stocker les définitions de fonctions *)
let init_functions_table fnum = 
    Hashtbl.create fnum

(* fonction pour charger toutes les fonctions dans un table de hachage 
 ce choix est motivé par le fait que les fonctions sont définies que dans le toplevel, qui est entierement connue et invariant lors de l'execution
*)
let load_function_into_table tbl tplvls =
    let rec load_function_into_table_rec = function
        | [] -> ()
        | Ast.Function(func) :: tl -> 
            Hashtbl.add tbl func.f_name func;
            load_function_into_table_rec tl
        | _ :: tl -> load_function_into_table_rec tl
    in
    load_function_into_table_rec tplvls