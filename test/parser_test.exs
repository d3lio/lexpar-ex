defmodule ParserTest do
  use ExUnit.Case
  alias Lexpar.Parser
  doctest Lexpar.Parser

  describe "Lexpar.Parse.pair_with_guard" do
    test "returns var when there is no guards provided" do
      var = {:e, [], nil}
      assert Parser.pair_with_guard(var, []) === var
    end

    test "returns var when there is no guards to pair with" do
      var = {:n, [], nil}
      assert Parser.pair_with_guard(var, [{:is_expr, [], [{:e, [], nil}]}]) === var
    end

    test "pairs var with single guard" do
      var = {:e, [], nil}
      assert Parser.pair_with_guard(var, [{:is_expr, [], [var]}]) === {:guarded, var, :expr}
    end

    test "pairs var with a guard from multiple guards" do
      var = {:n, [], nil}
      assert Parser.pair_with_guard(var, [
        {:is_number, [], [var]},
        {:is_expr, [], [{:e, [], nil}]}
      ]) === {:guarded, var, :number}
    end
  end
end
