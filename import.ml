open Lexing
open Parser
open Lexer
open Namespace

module NameSet = Set.Make(String);;

let load_file fname = 
    let ic = open_in fname in
    let lexbuf = Lexing.from_channel ic in
    let ast = Parser.componants Lexer.lex lexbuf in
    close_in ic;
    ast

(* Fonction permettant d'extraire les imports d'une liste de top_level *)
let filter_imports tplvls = 
    let rec filter_imports_rec tplvls imports others = 
        match tplvls with
        | [] -> (imports, others)
        | Ast.Import(fname) :: tl -> 
            filter_imports_rec tl (fname :: imports) others
        | hd :: tl -> filter_imports_rec tl imports (hd :: others)
    in
    filter_imports_rec tplvls [] []

(* Fonction permettant de resoudre tous les imports naivement *)
let resolve_imports tplvls entrypoint = 
    let init_loaded_files = NameSet.singleton entrypoint in
    let init_namespace = extract_names tplvls entrypoint in
    let imports, filtered_ast = filter_imports tplvls in
    let rec add_files tplvls_acc loaded_files namespace import_list = 
        match import_list with
        | [] -> (tplvls_acc, namespace)
        | fname :: tl -> 
            if NameSet.mem fname loaded_files then
                add_files tplvls_acc loaded_files namespace tl
            else
                let fname_formatted = fname ^ ".template" in
                let ast = load_file fname_formatted in
                let new_namespace = merge_names namespace (extract_names ast fname) in
                let new_imports, new_filtered_ast = filter_imports ast in
                add_files (tplvls_acc @ new_filtered_ast) (NameSet.add fname loaded_files) new_namespace (new_imports @ tl)
    in
    add_files filtered_ast init_loaded_files init_namespace imports