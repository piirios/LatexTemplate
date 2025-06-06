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