defmodule Lexpar do
  use Lexpar.Parser, entry: :expr

  defnonterm expr do
    ?(, e, ?) when is_expr(e) -> e
    e when is_number(e) -> e
    e, k when is_number(e) and is_atom(k) and true -> e
    e, _ -> e
    expr(e) -> e
    @eps -> nil
  end

  # fn f a b c = ...
  defnonterm function do
    "fn", name, a.*, "=", expr.* when is_ident(a) -> a
  end
end
