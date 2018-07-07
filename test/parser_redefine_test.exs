defmodule ParserRedefineTest do
  use ExUnit.Case

  describe "Improper parser" do
    defmodule Parser do
      use Lexpar.Parser, entry: parse

      defnonterm parse do
        "should be" -> "fine"
      end

      defnonterm iterator do
        "why would you even..." -> "need such a generic nonterm"
      end
    end

    test "generated as expected" do
      assert Parser.parse(["should be"]) === {:ok, "fine", []}
    end
  end
end
