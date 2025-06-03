open Ast

let version = "0.01" (* Ou la version actuelle de votre projet *)

let usage () =
  Printf.eprintf
    "Usage: %s [fichier.template]
\tAnalyse un fichier LatexTemplate (entrée standard par défaut)
%!"
    Sys.argv.(0);
  exit 1

let main () =
  let input_channel =
    match Array.length Sys.argv with
    | 1 -> stdin
    | 2 ->
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
    Printf.printf "=== ARBRE DE SYNTAXE ABSTRAIT (AST) ===
";
    List.iter
      (fun item ->
        Ast.print_toplevel stdout item;
        Printf.printf "\n----------------------------------------\n")
      toplevel_items;
    Printf.printf "
🏁 Analyse terminée.
%!";
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

let () =
  if !Sys.interactive then () else main ()