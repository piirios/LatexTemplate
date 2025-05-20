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
        | _ -> IDENT(lxm) )
# 303 "textemplatecorelexer.ml"

  | 4 ->
# 102 "textemplatecorelexer.mll"
          ( COLONEQUAL )
# 308 "textemplatecorelexer.ml"

  | 5 ->
# 103 "textemplatecorelexer.mll"
           ( EQUALEQUAL )
# 313 "textemplatecorelexer.ml"

  | 6 ->
# 104 "textemplatecorelexer.mll"
          ( GREATER)
# 318 "textemplatecorelexer.ml"

  | 7 ->
# 104 "textemplatecorelexer.mll"
                            ( SMALLER )
# 323 "textemplatecorelexer.ml"

  | 8 ->
# 105 "textemplatecorelexer.mll"
          ( GREATEREQUAL)
# 328 "textemplatecorelexer.ml"

  | 9 ->
# 105 "textemplatecorelexer.mll"
                                  ( SMALLEREQUAL )
# 333 "textemplatecorelexer.ml"

  | 10 ->
# 106 "textemplatecorelexer.mll"
          ( PLUS )
# 338 "textemplatecorelexer.ml"

  | 11 ->
# 106 "textemplatecorelexer.mll"
                           ( MINUS )
# 343 "textemplatecorelexer.ml"

  | 12 ->
# 106 "textemplatecorelexer.mll"
                                           ( MULT )
# 348 "textemplatecorelexer.ml"

  | 13 ->
# 106 "textemplatecorelexer.mll"
                                                          ( DIV )
# 353 "textemplatecorelexer.ml"

  | 14 ->
# 107 "textemplatecorelexer.mll"
          ( SEMICOLON )
# 358 "textemplatecorelexer.ml"

  | 15 ->
# 108 "textemplatecorelexer.mll"
          ( COMMA )
# 363 "textemplatecorelexer.ml"

  | 16 ->
# 109 "textemplatecorelexer.mll"
          ( DOUBLEDOT )
# 368 "textemplatecorelexer.ml"

  | 17 ->
# 110 "textemplatecorelexer.mll"
           ( UNIT )
# 373 "textemplatecorelexer.ml"

  | 18 ->
# 111 "textemplatecorelexer.mll"
          ( LPAREN )
# 378 "textemplatecorelexer.ml"

  | 19 ->
# 112 "textemplatecorelexer.mll"
          ( RPAREN )
# 383 "textemplatecorelexer.ml"

  | 20 ->
# 113 "textemplatecorelexer.mll"
          ( LSIMPLEBRACE )
# 388 "textemplatecorelexer.ml"

  | 21 ->
# 114 "textemplatecorelexer.mll"
          ( RSIMPLEBRACE )
# 393 "textemplatecorelexer.ml"

  | 22 ->
# 115 "textemplatecorelexer.mll"
          ( LBRACKET )
# 398 "textemplatecorelexer.ml"

  | 23 ->
# 116 "textemplatecorelexer.mll"
          ( RBRACKET )
# 403 "textemplatecorelexer.ml"

  | 24 ->
# 117 "textemplatecorelexer.mll"
          ( reset_string_buffer();
            in_string lexbuf;
            STRING (get_stored_string()) )
# 410 "textemplatecorelexer.ml"

  | 25 ->
# 120 "textemplatecorelexer.mll"
          ( in_cpp_comment lexbuf )
# 415 "textemplatecorelexer.ml"

  | 26 ->
# 121 "textemplatecorelexer.mll"
          ( in_c_comment lexbuf )
# 420 "textemplatecorelexer.ml"

  | 27 ->
# 122 "textemplatecorelexer.mll"
          ( EOF )
# 425 "textemplatecorelexer.ml"

  | 28 ->
let
# 123 "textemplatecorelexer.mll"
          c
# 431 "textemplatecorelexer.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 123 "textemplatecorelexer.mll"
            ( Printf.eprintf "Invalid char `%c'\n%!" c ; lex lexbuf )
# 435 "textemplatecorelexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_lex_rec lexbuf __ocaml_lex_state

and in_string lexbuf =
   __ocaml_lex_in_string_rec lexbuf 32
and __ocaml_lex_in_string_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 127 "textemplatecorelexer.mll"
      ( () )
# 447 "textemplatecorelexer.ml"

  | 1 ->
# 129 "textemplatecorelexer.mll"
      ( store_string_char(char_for_backslash(Lexing.lexeme_char lexbuf 1));
        in_string lexbuf )
# 453 "textemplatecorelexer.ml"

  | 2 ->
# 132 "textemplatecorelexer.mll"
      ( store_string_char(char_for_decimal_code lexbuf 1);
        in_string lexbuf )
# 459 "textemplatecorelexer.ml"

  | 3 ->
# 135 "textemplatecorelexer.mll"
      ( store_string_char(char_for_hexadecimal_code lexbuf 2);
         in_string lexbuf )
# 465 "textemplatecorelexer.ml"

  | 4 ->
let
# 137 "textemplatecorelexer.mll"
              chars
# 471 "textemplatecorelexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos (lexbuf.Lexing.lex_start_pos + 2) in
# 138 "textemplatecorelexer.mll"
      ( skip_to_eol lexbuf; raise (Failure("Illegal escape: " ^ chars)) )
# 475 "textemplatecorelexer.ml"

  | 5 ->
let
# 139 "textemplatecorelexer.mll"
               s
# 481 "textemplatecorelexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 140 "textemplatecorelexer.mll"
      ( for i = 0 to String.length s - 1 do
          store_string_char s.[i];
        done;
        in_string lexbuf
      )
# 489 "textemplatecorelexer.ml"

  | 6 ->
# 146 "textemplatecorelexer.mll"
      ( raise Eoi )
# 494 "textemplatecorelexer.ml"

  | 7 ->
let
# 147 "textemplatecorelexer.mll"
         c
# 500 "textemplatecorelexer.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 148 "textemplatecorelexer.mll"
      ( store_string_char c; in_string lexbuf )
# 504 "textemplatecorelexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_in_string_rec lexbuf __ocaml_lex_state

and in_cpp_comment lexbuf =
   __ocaml_lex_in_cpp_comment_rec lexbuf 47
and __ocaml_lex_in_cpp_comment_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 151 "textemplatecorelexer.mll"
         ( lex lexbuf )
# 516 "textemplatecorelexer.ml"

  | 1 ->
# 152 "textemplatecorelexer.mll"
         ( in_cpp_comment lexbuf )
# 521 "textemplatecorelexer.ml"

  | 2 ->
# 153 "textemplatecorelexer.mll"
         ( raise Eoi )
# 526 "textemplatecorelexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_in_cpp_comment_rec lexbuf __ocaml_lex_state

and in_c_comment lexbuf =
   __ocaml_lex_in_c_comment_rec lexbuf 51
and __ocaml_lex_in_c_comment_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 156 "textemplatecorelexer.mll"
         ( lex lexbuf )
# 538 "textemplatecorelexer.ml"

  | 1 ->
# 157 "textemplatecorelexer.mll"
         ( in_c_comment lexbuf )
# 543 "textemplatecorelexer.ml"

  | 2 ->
# 158 "textemplatecorelexer.mll"
         ( raise Eoi )
# 548 "textemplatecorelexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_in_c_comment_rec lexbuf __ocaml_lex_state

and skip_to_eol lexbuf =
   __ocaml_lex_skip_to_eol_rec lexbuf 56
and __ocaml_lex_skip_to_eol_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 161 "textemplatecorelexer.mll"
            ( () )
# 560 "textemplatecorelexer.ml"

  | 1 ->
# 162 "textemplatecorelexer.mll"
            ( skip_to_eol lexbuf )
# 565 "textemplatecorelexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_skip_to_eol_rec lexbuf __ocaml_lex_state

;;

