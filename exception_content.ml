(* Exception pour les doublons de noms dans un fichier *)
type duplicate_name = {
    name : string;
    file : string;
}

exception Duplicate_name of duplicate_name;;

let make_duplicate_name name file = { name; file };;

let print_duplicate_name oc { name; file } = 
    Printf.fprintf oc "Le nom %s est déjà défini dans le fichier %s" name file


(* Exception pour les doublons de noms dans un fichier importé *)
type duplicate_name_import = {
    name : string;
    file1 : string;
    file2 : string;
}

exception Duplicate_name_import of duplicate_name_import;;

let make_duplicate_name_import name file1 file2 = { name; file1; file2 };;

let print_duplicate_name_import oc { name; file1; file2 } = 
    Printf.fprintf oc "Le nom %s est déjà défini dans les fichiers %s et %s" name file1 file2


(* Exception pour les variables non définies *)
type undefined_variable = {
    var_name : string;
    context : string;
}

exception Undefined_variable of undefined_variable;;

let make_undefined_variable var_name context = { var_name; context };;

let print_undefined_variable oc { var_name; context } = 
    Printf.fprintf oc "Variable '%s' non définie dans le contexte : %s" var_name context


(* Exception pour les fonctions non définies *)
type undefined_function = {
    func_name : string;
    available_functions : string list;
}

exception Undefined_function of undefined_function;;

let make_undefined_function func_name available_functions = { func_name; available_functions };;

let print_undefined_function oc { func_name; available_functions } = 
    Printf.fprintf oc "Fonction '%s' non définie. Fonctions disponibles : [%s]" func_name (String.concat "; " available_functions)


(* Exception pour les erreurs d'opérateurs *)
type operator_error = {
    operator : string;
    left_type : string;
    right_type : string option;
    context : string;
}

exception Operator_error of operator_error;;

let make_operator_error operator left_type right_type context = { operator; left_type; right_type; context };;

let print_operator_error oc { operator; left_type; right_type; context } = 
    match right_type with
    | Some rt -> Printf.fprintf oc "Opérateur '%s' non supporté entre %s et %s dans : %s" operator left_type rt context
    | None -> Printf.fprintf oc "Opérateur unaire '%s' non supporté sur %s dans : %s" operator left_type context


(* Exception pour les erreurs d'index de tableau *)
type array_index_error = {
    array_name : string;
    index : int;
    array_size : int;
    context : string;
}

exception Array_index_error of array_index_error;;

let make_array_index_error array_name index array_size context = { array_name; index; array_size; context };;

let print_array_index_error oc { array_name; index; array_size; context } = 
    Printf.fprintf oc "Index %d hors limites pour le tableau '%s' (taille: %d) dans : %s" index array_name array_size context


(* Exception pour les erreurs de type *)
type type_error = {
    expected : string;
    actual : string;
    context : string;
}

exception Type_error of type_error;;

let make_type_error expected actual context = { expected; actual; context };;

let print_type_error oc { expected; actual; context } = 
    Printf.fprintf oc "Erreur de type : attendu %s, reçu %s dans : %s" expected actual context


(* Exception pour les erreurs de division *)
type division_error = {
    operator : string;
    context : string;
}

exception Division_error of division_error;;

let make_division_error operator context = { operator; context };;

let print_division_error oc { operator; context } = 
    Printf.fprintf oc "Division par zéro avec l'opérateur '%s' dans : %s" operator context


(* Exception pour les erreurs d'exécution de template *)
type template_error = {
    template_func : string;
    error_msg : string;
    context : string;
}

exception Template_error of template_error;;

let make_template_error template_func error_msg context = { template_func; error_msg; context };;

let print_template_error oc { template_func; error_msg; context } = 
    Printf.fprintf oc "Erreur de template dans '%s' : %s (contexte: %s)" template_func error_msg context


(* Exception pour les erreurs de fichier *)
type file_error = {
    file_path : string;
    operation : string;
    system_error : string;
}

exception File_error of file_error;;

let make_file_error file_path operation system_error = { file_path; operation; system_error };;

let print_file_error oc { file_path; operation; system_error } = 
    Printf.fprintf oc "Erreur de fichier lors de %s sur '%s' : %s" operation file_path system_error