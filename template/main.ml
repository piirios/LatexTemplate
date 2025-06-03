open Ast

let parse_file filename =
  let ic = open_in filename in
  let lexbuf = Lexing.from_channel ic in
  try
    let result = Templateparser.template Templatelexer.lex lexbuf in
    close_in ic;
    result
  with
  | Parsing.Parse_error ->
      let pos = Lexing.lexeme_start_p lexbuf in
      Printf.eprintf "Erreur de syntaxe à la ligne %d, caractère %d\n"
        pos.Lexing.pos_lnum
        (pos.Lexing.pos_cnum - pos.Lexing.pos_bol);
      close_in ic;
      exit 1
  | Templatelexer.LexError (start_pos, end_pos) ->
      Printf.eprintf "Erreur lexicale entre les positions %d et %d\n"
        start_pos.Lexing.pos_cnum end_pos.Lexing.pos_cnum;
      close_in ic;
      exit 1

let rec print_expr = function
  | Int i -> Printf.printf "%d" i
  | String s -> Printf.printf "\"%s\"" s
  | Ident id -> Printf.printf "%s" id
  | Bool b -> Printf.printf "%b" b
  | Unit -> Printf.printf "()"
  | Range (start, None) -> 
      print_expr start; Printf.printf ".."
  | Range (start, Some end_expr) ->
      print_expr start; Printf.printf ".."; print_expr end_expr
  | Binop (op, e1, e2) ->
      Printf.printf "(";
      print_expr e1;
      Printf.printf " %s " op;
      print_expr e2;
      Printf.printf ")"
  | Monop (op, e) ->
      Printf.printf "(%s" op;
      print_expr e;
      Printf.printf ")"
  | App (f, args) ->
      Printf.printf "%s(" f;
      List.iter (fun e -> print_expr e; Printf.printf " ") args;
      Printf.printf ")"
  | _ -> Printf.printf "[complex expression]"

let rec print_template_element = function
  | LatexContent s -> 
      if String.length (String.trim s) > 0 then 
        Printf.printf "String: \"%s\"\n" s
  | If (expr, then_elems, else_elems) ->
      Printf.printf "If condition: ";
      print_expr expr;
      Printf.printf "\nThen:\n";
      List.iter print_template_element then_elems;
      (match else_elems with
       | [] -> ()
       | elems ->
           Printf.printf "Else:\n";
           List.iter print_template_element elems);
      Printf.printf "EndIf\n"
  | For (var, expr, body) ->
      Printf.printf "For %s in " var;
      print_expr expr;
      Printf.printf ":\n";
      List.iter print_template_element body;
      Printf.printf "EndFor\n"
  | While (expr, body) ->
      Printf.printf "While ";
      print_expr expr;
      Printf.printf ":\n";
      List.iter print_template_element body;
      Printf.printf "EndWhile\n"
  | Loop elems ->
      Printf.printf "Loop:\n";
      List.iter print_template_element elems;
      Printf.printf "EndLoop\n"
  | Import (comp, args) ->
      Printf.printf "Import component: %s with args: " comp;
      List.iter (fun e -> print_expr e; Printf.printf " ") args;
      Printf.printf "\n"
  | Break ->
      Printf.printf "Break\n"
  | Expression expr ->
      Printf.printf "Variable access: ";
      print_expr expr;
      Printf.printf "\n"
  | _ -> Printf.printf "[other template element]\n"

let print_template template_list =
  Printf.printf "Template:\n";
  List.iter print_template_element template_list

let () =
  if Array.length Sys.argv < 2 then begin
    Printf.eprintf "Usage: %s <fichier.templatetemplate>\n" Sys.argv.(0);
    exit 1
  end;
  
  let filename = Sys.argv.(1) in
  let template = parse_file filename in
  print_template template 