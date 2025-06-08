type name_source_type = 
| Function
| Variable


(* Type pour stocker un nom et son fichier source ainsi que ce qu'il represente *)
type name_source = {
  name: string;
  source: string;
  context: name_source_type;
}

(* Module pour comparer les name_source uniquement sur le nom *)
module NameSourceComp = struct
  type t = name_source
  let compare n1 n2 = String.compare n1.name n2.name
end

module NameSourceSet = Set.Make(NameSourceComp);;

exception Duplicate_name of string;;

(* Fonction permettant d'extraire le namespace d'une liste de top_level *)
let extract_names tplvls fname =  
    let set = NameSourceSet.empty in
    let rec extract_names_rec tplvls sec_acc = 
        match tplvls with
        | [] -> sec_acc
        | Ast.Function(func) :: tl -> 
            let name_src = {name = func.f_name; source = fname; context = Function} in
            if NameSourceSet.mem name_src sec_acc then 
                raise (Exception_content.Duplicate_name (Exception_content.make_duplicate_name func.f_name fname))
            else extract_names_rec tl (NameSourceSet.add name_src sec_acc)
        | Ast.Instruction(Ast.Declare(name, _)) :: tl ->
            let name_src = {name = name; source = fname; context = Variable} in
            if NameSourceSet.mem name_src sec_acc then
                raise (Exception_content.Duplicate_name (Exception_content.make_duplicate_name name fname))
            else extract_names_rec tl (NameSourceSet.add name_src sec_acc)
        | _ :: tl -> extract_names_rec tl sec_acc       
    in
    extract_names_rec tplvls set

(* Fonction permettant de fusionner deux namespaces *)
let merge_names names1 names2 = 
    let check_duplicate name_src =
        if NameSourceSet.mem name_src names1 then
            let other_src = NameSourceSet.find name_src names1 in
            raise (Exception_content.Duplicate_name_import 
                (Exception_content.make_duplicate_name_import name_src.name name_src.source other_src.source))
    in
    NameSourceSet.iter check_duplicate names2;
    NameSourceSet.union names1 names2


let count_names names = 
    let rec count_names_rec names fun_acc var_acc = 
        match names with
        | [] -> (fun_acc, var_acc)
        | {context = Function} :: tl -> count_names_rec tl (fun_acc + 1) var_acc
        | {context = Variable} :: tl -> count_names_rec tl fun_acc (var_acc + 1)
    in
    count_names_rec (NameSourceSet.to_list names) 0 0