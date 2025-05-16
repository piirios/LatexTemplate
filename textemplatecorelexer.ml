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


# 66 "textemplatecorelexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base =
   "\000\000\229\255\230\255\233\255\234\255\235\255\236\255\237\255\
    \238\255\017\000\017\000\242\255\243\255\082\000\245\255\246\255\
    \247\255\003\000\031\000\033\000\082\000\157\000\001\000\255\255\
    \252\255\249\255\248\255\231\255\232\255\241\255\240\255\004\000\
    \248\255\249\255\002\000\250\255\183\000\255\255\251\255\217\000\
    \193\000\254\255\000\001\253\255\016\001\252\255\005\000\253\255\
    \254\255\255\255\098\000\253\255\254\255\048\000\255\255\006\000\
    \254\255\008\000\255\255";
  Lexing.lex_backtrk =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\016\000\026\000\255\255\255\255\011\000\255\255\255\255\
    \255\255\005\000\004\000\026\000\002\000\001\000\000\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\005\000\255\255\007\000\255\255\255\255\004\000\
    \004\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\001\000\255\255\255\255\
    \255\255\000\000\255\255";
  Lexing.lex_default =
   "\001\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\255\255\255\255\000\000\000\000\255\255\000\000\000\000\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\032\000\
    \000\000\000\000\255\255\000\000\038\000\000\000\000\000\255\255\
    \255\255\000\000\255\255\000\000\255\255\000\000\048\000\000\000\
    \000\000\000\000\052\000\000\000\000\000\255\255\000\000\056\000\
    \000\000\255\255\000\000";
  Lexing.lex_trans =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\023\000\023\000\023\000\035\000\022\000\035\000\049\000\
    \058\000\034\000\058\000\057\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \023\000\000\000\003\000\000\000\000\000\000\000\037\000\000\000\
    \009\000\008\000\014\000\016\000\011\000\015\000\010\000\013\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\030\000\012\000\017\000\019\000\018\000\029\000\
    \026\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\005\000\025\000\004\000\024\000\054\000\
    \036\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\007\000\027\000\006\000\000\000\000\000\
    \000\000\028\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\053\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\000\000\000\000\000\000\
    \000\000\020\000\000\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\041\000\
    \000\000\041\000\000\000\000\000\000\000\000\000\041\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\040\000\
    \040\000\040\000\040\000\040\000\040\000\040\000\040\000\040\000\
    \040\000\042\000\042\000\042\000\042\000\042\000\042\000\042\000\
    \042\000\042\000\042\000\000\000\000\000\000\000\000\000\000\000\
    \002\000\000\000\000\000\000\000\033\000\047\000\255\255\000\000\
    \000\000\044\000\044\000\044\000\044\000\044\000\044\000\044\000\
    \044\000\044\000\044\000\041\000\000\000\000\000\000\000\000\000\
    \000\000\041\000\044\000\044\000\044\000\044\000\044\000\044\000\
    \000\000\000\000\000\000\000\000\000\000\041\000\000\000\000\000\
    \000\000\041\000\000\000\041\000\000\000\000\000\000\000\039\000\
    \043\000\043\000\043\000\043\000\043\000\043\000\043\000\043\000\
    \043\000\043\000\044\000\044\000\044\000\044\000\044\000\044\000\
    \045\000\045\000\045\000\045\000\045\000\045\000\045\000\045\000\
    \045\000\045\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\045\000\045\000\045\000\045\000\045\000\045\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\051\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\045\000\045\000\045\000\045\000\045\000\045\000\000\000\
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
    \255\255\000\000\000\000\022\000\034\000\000\000\031\000\046\000\
    \055\000\031\000\057\000\055\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\000\000\255\255\255\255\255\255\031\000\255\255\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\009\000\000\000\000\000\000\000\000\000\010\000\
    \017\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\018\000\000\000\019\000\053\000\
    \031\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\013\000\000\000\255\255\255\255\
    \255\255\013\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\050\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\255\255\255\255\255\255\
    \255\255\020\000\255\255\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\036\000\
    \255\255\036\000\255\255\255\255\255\255\255\255\036\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\036\000\
    \036\000\036\000\036\000\036\000\036\000\036\000\036\000\036\000\
    \036\000\040\000\040\000\040\000\040\000\040\000\040\000\040\000\
    \040\000\040\000\040\000\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\031\000\046\000\055\000\255\255\
    \255\255\039\000\039\000\039\000\039\000\039\000\039\000\039\000\
    \039\000\039\000\039\000\036\000\255\255\255\255\255\255\255\255\
    \255\255\036\000\039\000\039\000\039\000\039\000\039\000\039\000\
    \255\255\255\255\255\255\255\255\255\255\036\000\255\255\255\255\
    \255\255\036\000\255\255\036\000\255\255\255\255\255\255\036\000\
    \042\000\042\000\042\000\042\000\042\000\042\000\042\000\042\000\
    \042\000\042\000\039\000\039\000\039\000\039\000\039\000\039\000\
    \044\000\044\000\044\000\044\000\044\000\044\000\044\000\044\000\
    \044\000\044\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\044\000\044\000\044\000\044\000\044\000\044\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\050\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\044\000\044\000\044\000\044\000\044\000\044\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\036\000\
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
# 69 "textemplatecorelexer.mll"
      ( lex lexbuf )
# 252 "textemplatecorelexer.ml"

  | 1 ->
let
# 70 "textemplatecorelexer.mll"
                  lxm
# 258 "textemplatecorelexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 71 "textemplatecorelexer.mll"
      ( INT(int_of_string lxm) )
# 262 "textemplatecorelexer.ml"

  | 2 ->
let
# 72 "textemplatecorelexer.mll"
                                                           lxm
# 268 "textemplatecorelexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 73 "textemplatecorelexer.mll"
      ( match lxm with
        | "let" -> LET
        | "if" -> IF
        | "elsif" -> ELSIF
        | "else" -> ELSE
        | "while" -> WHILE
        | "loop" -> LOOP
        | "return" -> RETURN
        | "print" -> PRINT
        | "true" -> TRUE
        | "false" -> FALSE
        | _ -> IDENT(lxm) )
# 283 "textemplatecorelexer.ml"

  | 3 ->
# 85 "textemplatecorelexer.mll"
           ( EQUALEQUAL )
# 288 "textemplatecorelexer.ml"

  | 4 ->
# 86 "textemplatecorelexer.mll"
          ( GREATER)
# 293 "textemplatecorelexer.ml"

  | 5 ->
# 86 "textemplatecorelexer.mll"
                            ( SMALLER )
# 298 "textemplatecorelexer.ml"

  | 6 ->
# 87 "textemplatecorelexer.mll"
          ( GREATEREQUAL)
# 303 "textemplatecorelexer.ml"

  | 7 ->
# 87 "textemplatecorelexer.mll"
                                  ( SMALLEREQUAL )
# 308 "textemplatecorelexer.ml"

  | 8 ->
# 88 "textemplatecorelexer.mll"
          ( PLUS )
# 313 "textemplatecorelexer.ml"

  | 9 ->
# 88 "textemplatecorelexer.mll"
                           ( MINUS )
# 318 "textemplatecorelexer.ml"

  | 10 ->
# 88 "textemplatecorelexer.mll"
                                           ( MULT )
# 323 "textemplatecorelexer.ml"

  | 11 ->
# 88 "textemplatecorelexer.mll"
                                                          ( DIV )
# 328 "textemplatecorelexer.ml"

  | 12 ->
# 89 "textemplatecorelexer.mll"
          ( SEMICOLON )
# 333 "textemplatecorelexer.ml"

  | 13 ->
# 90 "textemplatecorelexer.mll"
          ( COMMA )
# 338 "textemplatecorelexer.ml"

  | 14 ->
# 91 "textemplatecorelexer.mll"
          ( DOUBLEDOT )
# 343 "textemplatecorelexer.ml"

  | 15 ->
# 92 "textemplatecorelexer.mll"
           ( UNIT )
# 348 "textemplatecorelexer.ml"

  | 16 ->
# 93 "textemplatecorelexer.mll"
          ( LPAREN )
# 353 "textemplatecorelexer.ml"

  | 17 ->
# 94 "textemplatecorelexer.mll"
          ( RPAREN )
# 358 "textemplatecorelexer.ml"

  | 18 ->
# 95 "textemplatecorelexer.mll"
          ( LSIMPLEBRACE )
# 363 "textemplatecorelexer.ml"

  | 19 ->
# 96 "textemplatecorelexer.mll"
          ( RSIMPLEBRACE )
# 368 "textemplatecorelexer.ml"

  | 20 ->
# 97 "textemplatecorelexer.mll"
          ( LBRACKET )
# 373 "textemplatecorelexer.ml"

  | 21 ->
# 98 "textemplatecorelexer.mll"
          ( RBRACKET )
# 378 "textemplatecorelexer.ml"

  | 22 ->
# 99 "textemplatecorelexer.mll"
          ( reset_string_buffer();
            in_string lexbuf;
            STRING (get_stored_string()) )
# 385 "textemplatecorelexer.ml"

  | 23 ->
# 102 "textemplatecorelexer.mll"
          ( in_cpp_comment lexbuf )
# 390 "textemplatecorelexer.ml"

  | 24 ->
# 103 "textemplatecorelexer.mll"
          ( in_c_comment lexbuf )
# 395 "textemplatecorelexer.ml"

  | 25 ->
# 104 "textemplatecorelexer.mll"
          ( EOF )
# 400 "textemplatecorelexer.ml"

  | 26 ->
let
# 105 "textemplatecorelexer.mll"
          c
# 406 "textemplatecorelexer.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 105 "textemplatecorelexer.mll"
            ( Printf.eprintf "Invalid char `%c'\n%!" c ; lex lexbuf )
# 410 "textemplatecorelexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_lex_rec lexbuf __ocaml_lex_state

and in_string lexbuf =
   __ocaml_lex_in_string_rec lexbuf 31
and __ocaml_lex_in_string_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 109 "textemplatecorelexer.mll"
      ( () )
# 422 "textemplatecorelexer.ml"

  | 1 ->
# 111 "textemplatecorelexer.mll"
      ( store_string_char(char_for_backslash(Lexing.lexeme_char lexbuf 1));
        in_string lexbuf )
# 428 "textemplatecorelexer.ml"

  | 2 ->
# 114 "textemplatecorelexer.mll"
      ( store_string_char(char_for_decimal_code lexbuf 1);
        in_string lexbuf )
# 434 "textemplatecorelexer.ml"

  | 3 ->
# 117 "textemplatecorelexer.mll"
      ( store_string_char(char_for_hexadecimal_code lexbuf 2);
         in_string lexbuf )
# 440 "textemplatecorelexer.ml"

  | 4 ->
let
# 119 "textemplatecorelexer.mll"
              chars
# 446 "textemplatecorelexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos (lexbuf.Lexing.lex_start_pos + 2) in
# 120 "textemplatecorelexer.mll"
      ( skip_to_eol lexbuf; raise (Failure("Illegal escape: " ^ chars)) )
# 450 "textemplatecorelexer.ml"

  | 5 ->
let
# 121 "textemplatecorelexer.mll"
               s
# 456 "textemplatecorelexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 122 "textemplatecorelexer.mll"
      ( for i = 0 to String.length s - 1 do
          store_string_char s.[i];
        done;
        in_string lexbuf
      )
# 464 "textemplatecorelexer.ml"

  | 6 ->
# 128 "textemplatecorelexer.mll"
      ( raise Eoi )
# 469 "textemplatecorelexer.ml"

  | 7 ->
let
# 129 "textemplatecorelexer.mll"
         c
# 475 "textemplatecorelexer.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 130 "textemplatecorelexer.mll"
      ( store_string_char c; in_string lexbuf )
# 479 "textemplatecorelexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_in_string_rec lexbuf __ocaml_lex_state

and in_cpp_comment lexbuf =
   __ocaml_lex_in_cpp_comment_rec lexbuf 46
and __ocaml_lex_in_cpp_comment_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 133 "textemplatecorelexer.mll"
         ( lex lexbuf )
# 491 "textemplatecorelexer.ml"

  | 1 ->
# 134 "textemplatecorelexer.mll"
         ( in_cpp_comment lexbuf )
# 496 "textemplatecorelexer.ml"

  | 2 ->
# 135 "textemplatecorelexer.mll"
         ( raise Eoi )
# 501 "textemplatecorelexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_in_cpp_comment_rec lexbuf __ocaml_lex_state

and in_c_comment lexbuf =
   __ocaml_lex_in_c_comment_rec lexbuf 50
and __ocaml_lex_in_c_comment_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 138 "textemplatecorelexer.mll"
         ( lex lexbuf )
# 513 "textemplatecorelexer.ml"

  | 1 ->
# 139 "textemplatecorelexer.mll"
         ( in_c_comment lexbuf )
# 518 "textemplatecorelexer.ml"

  | 2 ->
# 140 "textemplatecorelexer.mll"
         ( raise Eoi )
# 523 "textemplatecorelexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_in_c_comment_rec lexbuf __ocaml_lex_state

and skip_to_eol lexbuf =
   __ocaml_lex_skip_to_eol_rec lexbuf 55
and __ocaml_lex_skip_to_eol_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 143 "textemplatecorelexer.mll"
            ( () )
# 535 "textemplatecorelexer.ml"

  | 1 ->
# 144 "textemplatecorelexer.mll"
            ( skip_to_eol lexbuf )
# 540 "textemplatecorelexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_skip_to_eol_rec lexbuf __ocaml_lex_state

;;

