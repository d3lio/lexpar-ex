defmodule ParserExprTest do
  use ExUnit.Case

  describe "Simple expression parser with parens and numbers" do
    defmodule Parser do
      use Lexpar.Parser, entry: expr

      defnonterm expr do
        ?(, e, ?) when is_expr(e) -> e
        e when is_number(e) -> e
      end
    end

    test "parses single number" do
      assert Parser.parse([1337]) === {:ok, 1337, []}
    end

    test "parses number with one set of parens" do
      assert Parser.parse([?(, 1337, ?)]) === {:ok, 1337, []}
    end

    test "parses number with two sets of parens" do
      assert Parser.parse([?(, ?(, 1337, ?), ?)]) === {:ok, 1337, []}
    end

    test "eof" do
      assert Parser.parse([]) === :eof
    end
  end
end
