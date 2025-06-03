open Template.Ast

let version = "0.01" ;;

let usage () =
  let _ =
    Printf.eprintf
      "Usage: %s [file]\n\tRead a PCF program from file (default is stdin)\n%!"
    Sys.argv.(0) in
  exit 1
;;

let parse_template_file filename =
  let ic = open_in filename in
  let lexbuf = Lexing.from_channel ic in
  try
    let result = Template.Parser.template Template.Lexer.lex lexbuf in
    close_in ic;
    result
  with
  | Parsing.Parse_error ->
      let pos = Lexing.lexeme_start_p lexbuf in
      Printf.eprintf "Erreur de syntaxe dans le template à la ligne %d, caractère %d\n"
        pos.Lexing.pos_lnum
        (pos.Lexing.pos_cnum - pos.Lexing.pos_bol);
      close_in ic;
      exit 1
  | Template.Lexer.LexError (start_pos, end_pos) ->
      Printf.eprintf "Erreur lexicale dans le template entre les positions %d et %d\n"
        start_pos.Lexing.pos_cnum end_pos.Lexing.pos_cnum;
      close_in ic;
      exit 1

let rec print_template_expr = function
  | Template.Ast.Int i -> Printf.printf "%d" i
  | Template.Ast.Float f -> Printf.printf "%f" f
  | Template.Ast.String s -> Printf.printf "\"%s\"" s
  | Template.Ast.Ident id -> Printf.printf "%s" id
  | Template.Ast.Bool b -> Printf.printf "%b" b
  | Template.Ast.Unit -> Printf.printf "()"
  | Template.Ast.Binop (op, e1, e2) ->
      Printf.printf "(";
      print_template_expr e1;
      Printf.printf " %s " op;
      print_template_expr e2;
      Printf.printf ")"
  | Template.Ast.Monop (op, e) ->
      Printf.printf "(%s" op;
      print_template_expr e;
      Printf.printf ")"
  | Template.Ast.App (f, args) ->
      Printf.printf "%s(" f;
      List.iter (fun e -> print_template_expr e; Printf.printf " ") args;
      Printf.printf ")"

let rec print_template_element = function
  | Template.Ast.TemplateString s -> Printf.printf "String: \"%s\"\n" s
  | Template.Ast.TemplateIf (expr, then_elems, else_elems) ->
      Printf.printf "If condition: ";
      print_template_expr expr;
      Printf.printf "\nThen:\n";
      List.iter print_template_element then_elems;
      (match else_elems with
       | Some elems ->
           Printf.printf "Else:\n";
           List.iter print_template_element elems
       | None -> ());
      Printf.printf "EndIf\n"
  | Template.Ast.TemplateLoop elems ->
      Printf.printf "Loop:\n";
      List.iter print_template_element elems;
      Printf.printf "EndLoop\n"
  | Template.Ast.TemplateUse (comp, args) ->
      Printf.printf "Use component: %s with args: " comp;
      List.iter (fun e -> print_template_expr e; Printf.printf " ") args;
      Printf.printf "\n"
  | Template.Ast.TemplateBreak ->
      Printf.printf "Break\n"
  | Template.Ast.TemplateVariable var ->
      Printf.printf "Variable: %s\n" var

let print_template template =
  Printf.printf "Template parsed successfully:\n";
  List.iter print_template_element template.Template.Ast.elements

let main() =
  let input_channel =
    match Array.length Sys.argv with
      1 -> stdin
    | 2 ->
        begin match Sys.argv.(1) with
          "-" -> stdin
        | name ->
            begin try open_in name with
              _ -> Printf.eprintf "Opening %s failed\n%!" name; exit 1
            end
        end
    | n -> usage()
  in
  let lexbuf = Lexing.from_channel input_channel in
  try
    let _ = Printf.printf "        Welcome to PCF, version %s\n%!" version in
    let prog = Parser.componant Lexer.lex lexbuf in
    let _ = Printf.printf "Recognized: " in
    Ast.print_componant stdout prog
  with
  | End_of_file -> ()
  | Parsing.Parse_error ->
      let sp = Lexing.lexeme_start_p lexbuf in
      let ep = Lexing.lexeme_end_p lexbuf in
      Format.eprintf
        "@[File %S, line %i, characters %i-%i:@ Syntax error.@]@\n"
        sp.Lexing.pos_fname
        sp.Lexing.pos_lnum
        (sp.Lexing.pos_cnum - sp.Lexing.pos_bol)
        (ep.Lexing.pos_cnum - ep.Lexing.pos_bol)
  | Lexer.LexError (sp, ep) ->
      Format.eprintf
        "@[File %S, line %i, characters %i-%i:@ Lexical error.@\n@]"
        sp.Lexing.pos_fname
        sp.Lexing.pos_lnum
        (sp.Lexing.pos_cnum - sp.Lexing.pos_bol)
        (ep.Lexing.pos_cnum - ep.Lexing.pos_bol)
;;

let () =
  if Array.length Sys.argv < 2 then begin
    Printf.eprintf "Usage: %s <fichier.ml ou fichier.templatetemplate>\n" Sys.argv.(0);
    exit 1
  end;
  
  let filename = Sys.argv.(1) in
  if Filename.check_suffix filename ".templatetemplate" then begin
    let template = parse_template_file filename in
    print_template template
  end else begin
    (* Code existant pour les autres fichiers *)
    Printf.printf "Parsing d'autres types de fichiers non implémenté\n"
  end

if !Sys.interactive then () else main();;