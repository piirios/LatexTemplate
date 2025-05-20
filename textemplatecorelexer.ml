# 1 "textemplatecorelexer.mll"
 
  open Textemplatecoreparser ;;
  exception Eoi ;;

  let pc c = Printf.eprintf "Lu '%c'\n%!" c;;
  let ps c = Printf.eprintf "Lu '%s'\n%!" c;;

  (* Emprunt� de l'analyseur lexical du compilateur OCaml *)
  (* To buffer string literals *)

  let initial_string_buffer = Bytes.create 256;;
  let string_buff = ref initial_string_buffer;;
  let string_index = ref 0;;

  let reset_string_buffer () =
    string_buff := initial_string_buffer;
    string_index := 0;;

  let store_string_char c =
    if !string_index >= Bytes.length (!string_buff) then begin
      let new_buff = Bytes.create (Bytes.length (!string_buff) * 2) in
      Bytes.blit (!string_buff) 0 new_buff 0 (Bytes.length (!string_buff));
      string_buff := new_buff
    end;
    Bytes.unsafe_set (!string_buff) (!string_index) c;
    incr string_index;;

  let get_stored_string () =
    let s = Bytes.to_string (Bytes.sub (!string_buff) 0 (!string_index)) in
    string_buff := initial_string_buffer;
    s;;

  (* To translate escape sequences *)

  let char_for_backslash c = match c with
  | 'n' -> '\010'
  | 'r' -> '\013'
  | 'b' -> '\008'
  | 't' -> '\009'
  | c   -> c

  let char_for_decimal_code lexbuf i =
    let c = 100 * (Char.code(Lexing.lexeme_char lexbuf i) - 48) +
             10 * (Char.code(Lexing.lexeme_char lexbuf (i+1)) - 48) +
                  (Char.code(Lexing.lexeme_char lexbuf (i+2)) - 48) in
    if (c < 0 || c > 255)
    then raise (Failure ("Illegal_escape: " ^ (Lexing.lexeme lexbuf)))
    else Char.chr c;;

  let char_for_hexadecimal_code lexbuf i =
    let d1 = Char.code (Lexing.lexeme_char lexbuf i) in
    let val1 = if d1 >= 97 then d1 - 87
               else if d1 >= 65 then d1 - 55
               else d1 - 48
    in
    let d2 = Char.code (Lexing.lexeme_char lexbuf (i+1)) in
    let val2 = if d2 >= 97 then d2 - 87
               else if d2 >= 65 then d2 - 55
               else d2 - 48
    in
    Char.chr (val1 * 16 + val2);;

    exception LexError of (Lexing.position * Lexing.position) ;;
let line_number = ref 0 ;;

let incr_line_number lexbuf =
  let pos = lexbuf.Lexing.lex_curr_p in
  lexbuf.Lexing.lex_curr_p <- { pos with
    Lexing.pos_lnum = pos.Lexing.pos_lnum + 1 ;
    Lexing.pos_bol = pos.Lexing.pos_cnum }
;;


# 76 "textemplatecorelexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base =
   "\000\000\227\255\228\255\231\255\232\255\233\255\234\255\235\255\
    \236\255\017\000\017\000\240\255\241\255\082\000\243\255\244\255\
    \245\255\003\000\031\000\033\000\082\000\157\000\001\000\254\255\
    \255\255\250\255\247\255\246\255\229\255\230\255\239\255\238\255\
    \004\000\248\255\249\255\002\000\250\255\183\000\255\255\251\255\
    \217\000\193\000\254\255\000\001\253\255\016\001\252\255\005\000\
    \253\255\254\255\255\255\098\000\253\255\254\255\048\000\255\255\
    \006\000\254\255\008\000\255\255";
  Lexing.lex_backtrk =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\018\000\028\000\255\255\255\255\013\000\255\255\255\255\
    \255\255\007\000\006\000\004\000\003\000\002\000\001\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\005\000\255\255\007\000\255\255\255\255\
    \004\000\004\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\001\000\255\255\
    \255\255\255\255\000\000\255\255";
  Lexing.lex_default =
   "\001\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\255\255\255\255\000\000\000\000\255\255\000\000\000\000\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \033\000\000\000\000\000\255\255\000\000\039\000\000\000\000\000\
    \255\255\255\255\000\000\255\255\000\000\255\255\000\000\049\000\
    \000\000\000\000\000\000\053\000\000\000\000\000\255\255\000\000\
    \057\000\000\000\255\255\000\000";
  Lexing.lex_trans =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\024\000\023\000\023\000\036\000\022\000\036\000\050\000\
    \059\000\035\000\059\000\058\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \024\000\000\000\003\000\000\000\000\000\000\000\038\000\000\000\
    \009\000\008\000\014\000\016\000\011\000\015\000\010\000\013\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\031\000\012\000\017\000\019\000\018\000\030\000\
    \027\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\005\000\026\000\004\000\025\000\055\000\
    \037\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\007\000\028\000\006\000\000\000\000\000\
    \000\000\029\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\054\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\000\000\000\000\000\000\
    \000\000\020\000\000\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\042\000\
    \000\000\042\000\000\000\000\000\000\000\000\000\042\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\041\000\
    \041\000\041\000\041\000\041\000\041\000\041\000\041\000\041\000\
    \041\000\043\000\043\000\043\000\043\000\043\000\043\000\043\000\
    \043\000\043\000\043\000\000\000\000\000\000\000\000\000\000\000\
    \002\000\000\000\000\000\000\000\034\000\048\000\255\255\000\000\
    \000\000\045\000\045\000\045\000\045\000\045\000\045\000\045\000\
    \045\000\045\000\045\000\042\000\000\000\000\000\000\000\000\000\
    \000\000\042\000\045\000\045\000\045\000\045\000\045\000\045\000\
    \000\000\000\000\000\000\000\000\000\000\042\000\000\000\000\000\
    \000\000\042\000\000\000\042\000\000\000\000\000\000\000\040\000\
    \044\000\044\000\044\000\044\000\044\000\044\000\044\000\044\000\
    \044\000\044\000\045\000\045\000\045\000\045\000\045\000\045\000\
    \046\000\046\000\046\000\046\000\046\000\046\000\046\000\046\000\
    \046\000\046\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\046\000\046\000\046\000\046\000\046\000\046\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\052\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\046\000\046\000\046\000\046\000\046\000\046\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\255\255\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000";
  Lexing.lex_check =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\022\000\035\000\000\000\032\000\047\000\
    \056\000\032\000\058\000\056\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\000\000\255\255\255\255\255\255\032\000\255\255\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\009\000\000\000\000\000\000\000\000\000\010\000\
    \017\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\018\000\000\000\019\000\054\000\
    \032\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\013\000\000\000\255\255\255\255\
    \255\255\013\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\051\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\255\255\255\255\255\255\
    \255\255\020\000\255\255\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\037\000\
    \255\255\037\000\255\255\255\255\255\255\255\255\037\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\037\000\
    \037\000\037\000\037\000\037\000\037\000\037\000\037\000\037\000\
    \037\000\041\000\041\000\041\000\041\000\041\000\041\000\041\000\
    \041\000\041\000\041\000\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\032\000\047\000\056\000\255\255\
    \255\255\040\000\040\000\040\000\040\000\040\000\040\000\040\000\
    \040\000\040\000\040\000\037\000\255\255\255\255\255\255\255\255\
    \255\255\037\000\040\000\040\000\040\000\040\000\040\000\040\000\
    \255\255\255\255\255\255\255\255\255\255\037\000\255\255\255\255\
    \255\255\037\000\255\255\037\000\255\255\255\255\255\255\037\000\
    \043\000\043\000\043\000\043\000\043\000\043\000\043\000\043\000\
    \043\000\043\000\040\000\040\000\040\000\040\000\040\000\040\000\
    \045\000\045\000\045\000\045\000\045\000\045\000\045\000\045\000\
    \045\000\045\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\045\000\045\000\045\000\045\000\045\000\045\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\051\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\045\000\045\000\045\000\045\000\045\000\045\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\037\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255";
  Lexing.lex_base_code =
   "";
  Lexing.lex_backtrk_code =
   "";
  Lexing.lex_default_code =
   "";
  Lexing.lex_trans_code =
   "";
  Lexing.lex_check_code =
   "";
  Lexing.lex_code =
   "";
}

let rec lex lexbuf =
   __ocaml_lex_lex_rec lexbuf 0
and __ocaml_lex_lex_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 79 "textemplatecorelexer.mll"
      ( lex lexbuf )
# 262 "textemplatecorelexer.ml"

  | 1 ->
# 81 "textemplatecorelexer.mll"
    ( incr_line_number lexbuf ;
      lex lexbuf )
# 268 "textemplatecorelexer.ml"

  | 2 ->
let
# 83 "textemplatecorelexer.mll"
                  lxm
# 274 "textemplatecorelexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 84 "textemplatecorelexer.mll"
      ( INT(int_of_string lxm) )
# 278 "textemplatecorelexer.ml"

  | 3 ->
let
# 85 "textemplatecorelexer.mll"
                                                           lxm
# 284 "textemplatecorelexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 86 "textemplatecorelexer.mll"
      ( match lxm with
        | "let" -> LET
        | "mut" -> MUT
        | "if" -> IF
        | "elsif" -> ELSIF
        | "else" -> ELSE
        | "while" -> WHILE
        | "loop" -> LOOP
        | "for" -> FOR
        | "in" -> IN
        | "return" -> RETURN
        | "print" -> PRINT
        | "true" -> TRUE
        | "false" -> FALSE
        | "break" -> BREAK
        | "fn" -> FN
        | _ -> IDENT(lxm) )
# 304 "textemplatecorelexer.ml"

  | 4 ->
# 103 "textemplatecorelexer.mll"
          ( COLONEQUAL )
# 309 "textemplatecorelexer.ml"

  | 5 ->
# 104 "textemplatecorelexer.mll"
           ( EQUALEQUAL )
# 314 "textemplatecorelexer.ml"

  | 6 ->
# 105 "textemplatecorelexer.mll"
          ( GREATER)
# 319 "textemplatecorelexer.ml"

  | 7 ->
# 105 "textemplatecorelexer.mll"
                            ( SMALLER )
# 324 "textemplatecorelexer.ml"

  | 8 ->
# 106 "textemplatecorelexer.mll"
          ( GREATEREQUAL)
# 329 "textemplatecorelexer.ml"

  | 9 ->
# 106 "textemplatecorelexer.mll"
                                  ( SMALLEREQUAL )
# 334 "textemplatecorelexer.ml"

  | 10 ->
# 107 "textemplatecorelexer.mll"
          ( PLUS )
# 339 "textemplatecorelexer.ml"

  | 11 ->
# 107 "textemplatecorelexer.mll"
                           ( MINUS )
# 344 "textemplatecorelexer.ml"

  | 12 ->
# 107 "textemplatecorelexer.mll"
                                           ( MULT )
# 349 "textemplatecorelexer.ml"

  | 13 ->
# 107 "textemplatecorelexer.mll"
                                                          ( DIV )
# 354 "textemplatecorelexer.ml"

  | 14 ->
# 108 "textemplatecorelexer.mll"
          ( SEMICOLON )
# 359 "textemplatecorelexer.ml"

  | 15 ->
# 109 "textemplatecorelexer.mll"
          ( COMMA )
# 364 "textemplatecorelexer.ml"

  | 16 ->
# 110 "textemplatecorelexer.mll"
          ( DOUBLEDOT )
# 369 "textemplatecorelexer.ml"

  | 17 ->
# 111 "textemplatecorelexer.mll"
           ( UNIT )
# 374 "textemplatecorelexer.ml"

  | 18 ->
# 112 "textemplatecorelexer.mll"
          ( LPAREN )
# 379 "textemplatecorelexer.ml"

  | 19 ->
# 113 "textemplatecorelexer.mll"
          ( RPAREN )
# 384 "textemplatecorelexer.ml"

  | 20 ->
# 114 "textemplatecorelexer.mll"
          ( LSIMPLEBRACE )
# 389 "textemplatecorelexer.ml"

  | 21 ->
# 115 "textemplatecorelexer.mll"
          ( RSIMPLEBRACE )
# 394 "textemplatecorelexer.ml"

  | 22 ->
# 116 "textemplatecorelexer.mll"
          ( LBRACKET )
# 399 "textemplatecorelexer.ml"

  | 23 ->
# 117 "textemplatecorelexer.mll"
          ( RBRACKET )
# 404 "textemplatecorelexer.ml"

  | 24 ->
# 118 "textemplatecorelexer.mll"
          ( reset_string_buffer();
            in_string lexbuf;
            STRING (get_stored_string()) )
# 411 "textemplatecorelexer.ml"

  | 25 ->
# 121 "textemplatecorelexer.mll"
          ( in_cpp_comment lexbuf )
# 416 "textemplatecorelexer.ml"

  | 26 ->
# 122 "textemplatecorelexer.mll"
          ( in_c_comment lexbuf )
# 421 "textemplatecorelexer.ml"

  | 27 ->
# 123 "textemplatecorelexer.mll"
          ( EOF )
# 426 "textemplatecorelexer.ml"

  | 28 ->
let
# 124 "textemplatecorelexer.mll"
          c
# 432 "textemplatecorelexer.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 124 "textemplatecorelexer.mll"
            ( Printf.eprintf "Invalid char `%c'\n%!" c ; lex lexbuf )
# 436 "textemplatecorelexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_lex_rec lexbuf __ocaml_lex_state

and in_string lexbuf =
   __ocaml_lex_in_string_rec lexbuf 32
and __ocaml_lex_in_string_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 128 "textemplatecorelexer.mll"
      ( () )
# 448 "textemplatecorelexer.ml"

  | 1 ->
# 130 "textemplatecorelexer.mll"
      ( store_string_char(char_for_backslash(Lexing.lexeme_char lexbuf 1));
        in_string lexbuf )
# 454 "textemplatecorelexer.ml"

  | 2 ->
# 133 "textemplatecorelexer.mll"
      ( store_string_char(char_for_decimal_code lexbuf 1);
        in_string lexbuf )
# 460 "textemplatecorelexer.ml"

  | 3 ->
# 136 "textemplatecorelexer.mll"
      ( store_string_char(char_for_hexadecimal_code lexbuf 2);
         in_string lexbuf )
# 466 "textemplatecorelexer.ml"

  | 4 ->
let
# 138 "textemplatecorelexer.mll"
              chars
# 472 "textemplatecorelexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos (lexbuf.Lexing.lex_start_pos + 2) in
# 139 "textemplatecorelexer.mll"
      ( skip_to_eol lexbuf; raise (Failure("Illegal escape: " ^ chars)) )
# 476 "textemplatecorelexer.ml"

  | 5 ->
let
# 140 "textemplatecorelexer.mll"
               s
# 482 "textemplatecorelexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 141 "textemplatecorelexer.mll"
      ( for i = 0 to String.length s - 1 do
          store_string_char s.[i];
        done;
        in_string lexbuf
      )
# 490 "textemplatecorelexer.ml"

  | 6 ->
# 147 "textemplatecorelexer.mll"
      ( raise Eoi )
# 495 "textemplatecorelexer.ml"

  | 7 ->
let
# 148 "textemplatecorelexer.mll"
         c
# 501 "textemplatecorelexer.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 149 "textemplatecorelexer.mll"
      ( store_string_char c; in_string lexbuf )
# 505 "textemplatecorelexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_in_string_rec lexbuf __ocaml_lex_state

and in_cpp_comment lexbuf =
   __ocaml_lex_in_cpp_comment_rec lexbuf 47
and __ocaml_lex_in_cpp_comment_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 152 "textemplatecorelexer.mll"
         ( lex lexbuf )
# 517 "textemplatecorelexer.ml"

  | 1 ->
# 153 "textemplatecorelexer.mll"
         ( in_cpp_comment lexbuf )
# 522 "textemplatecorelexer.ml"

  | 2 ->
# 154 "textemplatecorelexer.mll"
         ( raise Eoi )
# 527 "textemplatecorelexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_in_cpp_comment_rec lexbuf __ocaml_lex_state

and in_c_comment lexbuf =
   __ocaml_lex_in_c_comment_rec lexbuf 51
and __ocaml_lex_in_c_comment_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 157 "textemplatecorelexer.mll"
         ( lex lexbuf )
# 539 "textemplatecorelexer.ml"

  | 1 ->
# 158 "textemplatecorelexer.mll"
         ( in_c_comment lexbuf )
# 544 "textemplatecorelexer.ml"

  | 2 ->
# 159 "textemplatecorelexer.mll"
         ( raise Eoi )
# 549 "textemplatecorelexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_in_c_comment_rec lexbuf __ocaml_lex_state

and skip_to_eol lexbuf =
   __ocaml_lex_skip_to_eol_rec lexbuf 56
and __ocaml_lex_skip_to_eol_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 162 "textemplatecorelexer.mll"
            ( () )
# 561 "textemplatecorelexer.ml"

  | 1 ->
# 163 "textemplatecorelexer.mll"
            ( skip_to_eol lexbuf )
# 566 "textemplatecorelexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_skip_to_eol_rec lexbuf __ocaml_lex_state

;;

