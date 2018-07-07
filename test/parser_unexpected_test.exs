defmodule ParserUnexpectedTest do
  use ExUnit.Case

  describe "Unexpecting parser" do
    defmodule Parser do
      use Lexpar.Parser, entry: entry

      defnonterm entry do
        1, 2, 3 -> 123
      end
    end

    test "nomatch/unexpected first token" do
      assert Parser.parse([2, 4, 6]) === {:unexpected, 2, {:entry, -1, 0}}
    end

    test "unexpected token" do
      assert Parser.parse([1, 5, 7]) === {:unexpected, 5, {:entry, 0, 1}}
    end

    test "unexpected eof" do
      assert Parser.parse([1, 2]) === {:unexpected_eof, {:entry, 0, 2}}
    end
  end
end
