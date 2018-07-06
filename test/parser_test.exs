defmodule ParserTest do
  use ExUnit.Case
  doctest Lexpar.Parser

  describe "Parser with terms only" do
    defmodule Parser do
      use Lexpar.Parser, entry: abc

      defnonterm abc do
        ?a, ?b, ?c -> true
        _ -> false
      end
    end

    test "matches the correct arm" do
      assert Parser.parse('abc')
      assert !Parser.parse('ghj')
    end
  end
end
