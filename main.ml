let version = "0.01" (* Ou la version actuelle de votre projet *)

let usage () =
  Printf.eprintf
    "Usage: %s [fichier.template] [fichier_sortie.tex]
\tAnalyse un fichier LatexTemplate (entrée standard par défaut)
\tSi fichier_sortie.tex est spécifié, le template sera écrit dans ce fichier
%!"
    Sys.argv.(0);
  exit 1

let main () =
  let input_channel =
    match Array.length Sys.argv with
    | 1 -> stdin
    | 2 | 3 ->
        (match Sys.argv.(1) with
        | "-" -> stdin
        | name ->
            (try open_in name
            with Sys_error msg ->
              Printf.eprintf "Erreur à l\'ouverture du fichier '%s': %s
%!" name msg;
              exit 1))
    | _ -> usage ()
  in
  let lexbuf = Lexing.from_channel input_channel in
  Printf.printf "🚀 Bienvenue dans LatexTemplate Parser, version %s
%!" version;
  try
    if input_channel <> stdin then Printf.printf "📁 Analyse du fichier: %s
%!" Sys.argv.(1)
    else Printf.printf "⌨️  Lecture depuis l\'entrée standard...
%!";

    let toplevel_items = Parser.componants Lexer.lex lexbuf in
    Printf.printf "✅ Parsing réussi!

";
    let filename = if input_channel <> stdin then
      let full_name = Sys.argv.(1) in
      try
        Filename.chop_extension full_name
      with Invalid_argument _ -> full_name
    else "stdin" in
    let resolved_items, namespace = Import.resolve_imports toplevel_items filename in
    let fun_count, var_count = Namespace.count_names namespace in
    let fun_tbl = Mem.init_functions_table fun_count in 
    let toplvl_inst_expr = Mem.load_function_into_table fun_tbl resolved_items in
    Printf.printf "✅ %d fonctions et %d variables trouvées\n%!" fun_count var_count;
    Printf.printf "=== STRUCTURE AST (MODE DEBUG) ===
";
    Printf.printf "=== CONTENU DE LA TABLE DES FONCTIONS ===\n";
    Hashtbl.iter (fun name func_def ->
      Printf.printf "Fonction '%s':\n" name;
      List.iter (fun inst -> 
        Ast.print_dbg_instr stdout inst;
        Printf.printf "\n"
      ) func_def.Ast.body;
      Printf.printf "----------------------------------------\n"
    ) fun_tbl;

    Printf.printf "\n=== INSTRUCTIONS/EXPRESSIONS DE HAUT NIVEAU ===\n";
    List.iter (fun item ->
      match item with
      | Ast.Instruction inst -> 
          Printf.printf "Instruction: ";
          Ast.print_dbg_instr stdout inst;
          Printf.printf "\n"
      | Ast.Expression expr ->
          Printf.printf "Expression: ";
          Ast.print_dbg_expr stdout expr;
          Printf.printf "\n"
      | _ -> ()
    ) toplvl_inst_expr;

    (* Exécution de la fonction main si elle existe *)
    Printf.printf "\n=== EXÉCUTION ===\n";
    (try 
      let main_func = Hashtbl.find fun_tbl "main" in
      Printf.printf "🚀 Exécution de la fonction main...\n%!";
      
      (* Préparation des arguments argc et argv *)
      let argc = Array.length Sys.argv in
      let argv_list = Array.to_list (Array.map (fun s -> Sem.Vstring s) Sys.argv) in
      let argv_array = Sem.Varray argv_list in
      
      (* Création de l'environnement initial *)
      let env = Sem.init_env () in
      Sem.add_to_env env "_argc_main" (Sem.Vint argc);
      Sem.add_to_env env "_argv_main" argv_array;
      
      (* Exécution de la fonction main *)
      let result = Sem.eval_expr env fun_tbl (Ast.App ("main", [Ast.Ident "_argc_main"; Ast.Ident "_argv_main"])) in
      Printf.printf "✅ Fonction main terminée avec succès.\n";
      (match result with
       | Sem.Vint exit_code -> 
           Printf.printf "Code de sortie: %d\n" exit_code;
           if exit_code <> 0 then exit exit_code
       | Sem.Vtemplate template_result ->
           Printf.printf "=== RÉSULTAT TEMPLATE ===\n";
           (* Vérification du deuxième argument pour l'écriture dans un fichier *)
           (if Array.length Sys.argv >= 3 then
              let output_file = Array.get Sys.argv 2 in
              try
                let oc = open_out output_file in
                output_string oc template_result;
                close_out oc;
                Printf.printf "📄 Template écrit dans le fichier: %s\n" output_file
              with Sys_error msg ->
                Printf.eprintf "❌ Erreur lors de l'écriture du fichier '%s': %s\n" output_file msg;
                Printf.printf "Affichage sur stdout à la place:\n%s\n" template_result
           else
              Printf.printf "%s\n" template_result)
       | _ -> Printf.printf "Résultat: (autre type)\n")
    with 
    | Not_found -> Printf.printf "⚠️  Aucune fonction 'main' trouvée - pas d'exécution.\n%!"
    | Sem.Return_exception result -> 
        Printf.printf "✅ Fonction main terminée avec return.\n";
        (match result with
         | Sem.Vint exit_code -> 
             Printf.printf "Code de sortie: %d\n" exit_code;
             if exit_code <> 0 then exit exit_code
         | Sem.Vtemplate template_result ->
             Printf.printf "=== RÉSULTAT TEMPLATE ===\n";
             (* Vérification du deuxième argument pour l'écriture dans un fichier *)
             (if Array.length Sys.argv >= 3 then
                let output_file = Array.get Sys.argv 2 in
                try
                  let oc = open_out output_file in
                  output_string oc template_result;
                  close_out oc;
                  Printf.printf "📄 Template écrit dans le fichier: %s\n" output_file
                with Sys_error msg ->
                  Printf.eprintf "❌ Erreur lors de l'écriture du fichier '%s': %s\n" output_file msg;
                  Printf.printf "Affichage sur stdout à la place:\n%s\n" template_result
             else
                Printf.printf "%s\n" template_result)
         | _ -> Printf.printf "Résultat: (autre type)\n")
    | Failure msg -> 
        Printf.eprintf "❌ Erreur d'exécution: %s\n%!" msg;
        exit 3
    | Sem.Break_exception ->
        Printf.eprintf "❌ Break en dehors d'une boucle\n%!";
        exit 3);

    Printf.printf "\n🏁 Analyse terminée.\n%!";
    if input_channel <> stdin then close_in input_channel;
    exit 0
  with
  | Lexer.LexError (start_pos, end_pos) ->
      Printf.eprintf "\n❌ Erreur lexicale: entre les caractères %d et %d (ligne %d)
%!"
        start_pos.Lexing.pos_cnum end_pos.Lexing.pos_cnum start_pos.Lexing.pos_lnum;
      if input_channel <> stdin then close_in input_channel;
      exit 1
  | Parsing.Parse_error ->
      let pos = Lexing.lexeme_start_p lexbuf in
      Printf.eprintf "\n❌ Erreur de syntaxe: à la ligne %d, caractère %d
%!"
        pos.Lexing.pos_lnum
        (pos.Lexing.pos_cnum - pos.Lexing.pos_bol);
      if input_channel <> stdin then close_in input_channel;
      exit 1
  | Failure msg -> (* Pour d\'autres erreurs d\'exécution potentielles *)
      Printf.eprintf "\n❌ Erreur inattendue: %s
%!" msg;
      if input_channel <> stdin then close_in input_channel;
      exit 2
  | Exception_content.Duplicate_name dup_name ->
      Printf.eprintf "\n❌ %a\n%!" Exception_content.print_duplicate_name dup_name;
      if input_channel <> stdin then close_in input_channel;
      exit 1
  | Exception_content.Duplicate_name_import dup_name ->
      Printf.eprintf "\n❌ %a\n%!" Exception_content.print_duplicate_name_import dup_name;
      if input_channel <> stdin then close_in input_channel;
      exit 1
  | Sem.Return_exception _ ->
      Printf.eprintf "\n❌ Return en dehors d'une fonction\n%!";
      if input_channel <> stdin then close_in input_channel;
      exit 3
  | Sem.Break_exception ->
      Printf.eprintf "\n❌ Break en dehors d'une boucle\n%!";
      if input_channel <> stdin then close_in input_channel;
      exit 3

let () =
  if !Sys.interactive then () else main ()