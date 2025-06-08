let rec alpha_substitution_instr sub_tbl (instr : Ast.instr) : Ast.instr = match instr with
    | Ast.While(cond, body) -> 
        let new_cond = alpha_substitution_expr sub_tbl cond in
        let new_body = alpha_substitution sub_tbl body in
        Ast.While(new_cond, new_body)
    | Ast.For(var, range, body) -> 
        let new_range = alpha_substitution_expr sub_tbl range in
        let new_body = alpha_substitution sub_tbl body in
        Ast.For(var, new_range, new_body)
    | Ast.Loop(body) ->
        let new_body = alpha_substitution sub_tbl body in
        Ast.Loop(new_body)
    | Ast.If(cond, then_branch, else_branch) ->
        let new_cond = alpha_substitution_expr sub_tbl cond in
        let new_then = alpha_substitution sub_tbl then_branch in
        let new_else = alpha_substitution sub_tbl else_branch in
        Ast.If(new_cond, new_then, new_else)
    | Ast.Assign(var, expr) ->
        let new_expr = alpha_substitution_expr sub_tbl expr in
        Ast.Assign(var, new_expr)
    | Ast.Declare(var, decl) ->
        let new_decl = match decl with
        | Ast.Scalar(e) -> Ast.Scalar(alpha_substitution_expr sub_tbl e)
        | Ast.Array(es) -> Ast.Array(List.map (alpha_substitution_expr sub_tbl) es)
        in
        Ast.Declare(var, new_decl)
    | Ast.ArrayWrite(arr, idx, val_) ->
        let new_idx = alpha_substitution_expr sub_tbl idx in
        let new_val = alpha_substitution_expr sub_tbl val_ in
        Ast.ArrayWrite(arr, new_idx, new_val)
    | Ast.Return(e) -> 
        Ast.Return(alpha_substitution_expr sub_tbl e)
    | Ast.Iapp(f, args) ->
        Ast.Iapp(f, List.map (alpha_substitution_expr sub_tbl) args)
    | Ast.Print(exprs) ->
        Ast.Print(List.map (alpha_substitution_expr sub_tbl) exprs)
    | Ast.Break -> Ast.Break
and alpha_substitution_expr sub_tbl (expr : Ast.expr) : Ast.expr = match expr with
    | Ast.Int(i) -> Ast.Int(i)
    | Ast.Bool(b) -> Ast.Bool(b)
    | Ast.String(s) -> Ast.String(s)
    | Ast.Ident(x) -> 
        if Hashtbl.mem sub_tbl x then Hashtbl.find sub_tbl x else Ast.Ident(x)
    | Ast.ArrayRead(x, e) -> Ast.ArrayRead(x, alpha_substitution_expr sub_tbl e)
    | Ast.App(f, args) -> Ast.App(f, List.map (alpha_substitution_expr sub_tbl) args)
    | Ast.Monop(op, e) -> Ast.Monop(op, alpha_substitution_expr sub_tbl e)
    | Ast.Binop(op, e1, e2) -> Ast.Binop(op, alpha_substitution_expr sub_tbl e1, alpha_substitution_expr sub_tbl e2)
    | Ast.Range(e1, e2_opt) -> 
        let new_e1 = alpha_substitution_expr sub_tbl e1 in
        let new_e2_opt = match e2_opt with
            | None -> None
            | Some e2 -> Some(alpha_substitution_expr sub_tbl e2)
        in
        Ast.Range(new_e1, new_e2_opt)
    | Ast.Unit -> Ast.Unit
    | Ast.Template(t) -> Ast.Template(List.map (alpha_substitution_template sub_tbl) t)
and alpha_substitution_template sub_tbl (tmpl : Ast.template) : Ast.template = match tmpl with
    | Ast.LatexContent(s) -> Ast.LatexContent(s)
    | Ast.Expression(e) -> Ast.Expression(alpha_substitution_expr sub_tbl e)
    | Ast.For(var, range, body) ->
        let new_range = alpha_substitution_expr sub_tbl range in
        let new_body = List.map (alpha_substitution_template sub_tbl) body in
        Ast.For(var, new_range, new_body)
    | Ast.While(cond, body) ->
        let new_cond = alpha_substitution_expr sub_tbl cond in
        let new_body = List.map (alpha_substitution_template sub_tbl) body in
        Ast.While(new_cond, new_body)
    | Ast.Loop(body) ->
        let new_body = List.map (alpha_substitution_template sub_tbl) body in
        Ast.Loop(new_body)
    | Ast.If(cond, then_branch, else_branch) ->
        let new_cond = alpha_substitution_expr sub_tbl cond in
        let new_then = List.map (alpha_substitution_template sub_tbl) then_branch in
        let new_else = List.map (alpha_substitution_template sub_tbl) else_branch in
        Ast.If(new_cond, new_then, new_else)
    | Ast.Import(name, args) ->
        Ast.Import(name, List.map (alpha_substitution_expr sub_tbl) args)
    | Ast.Break -> Ast.Break
and alpha_substitution sub_tbl (code : Ast.instr list) : Ast.instr list = 
    List.map (alpha_substitution_instr sub_tbl) code
