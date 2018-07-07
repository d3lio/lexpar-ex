defmodule ParserArmTest do
  use ExUnit.Case

  describe "Parser with terms only" do
    defmodule Parser do
      use Lexpar.Parser, entry: abc

      defnonterm abc do
        ?a, ?b, ?c -> true
        _ -> false
      end
    end

    test "matches the correct arm" do
      assert Parser.parse('abc') === {:ok, true, []}
      assert Parser.parse('ghj') === {:ok, false, 'hj'}
    end
  end
end
