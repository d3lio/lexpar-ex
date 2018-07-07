defmodule ParserRecTest do
  use ExUnit.Case

  describe "Recursive parser" do
    defmodule Parser do
      use Lexpar.Parser, entry: function

      defnonterm function do
        "fn", ?(, args, ?) when is_args(args) -> args
      end

      defnonterm args do
        arg, args when is_atom(arg) and is_args(args) -> [arg | args]
        @eps -> []
      end
    end

    test "parses 0 arguments" do
      assert Parser.parse(["fn", ?(, ?)]) === {:ok, [], []}
    end

    test "parses 1 argument" do
      assert Parser.parse(["fn", ?(, :a, ?)]) === {:ok, [:a], []}
    end

    # TODO use quickcheck
    test "parses 5 arguments" do
      assert Parser.parse(["fn", ?(, :a, :b, :c, :d, :e, ?)]) ===
        {:ok, [:a, :b, :c, :d, :e], []}
    end
  end
end
