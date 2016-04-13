defmodule ParserTest do
  use ExUnit.Case
  doctest Zkbl.Parser
  alias Zkbl.Parser

  test "Reconstruction of simple strings" do
    test = ["'foo", "bar'"]
    expected = ["'foo bar'"]

    assert Parser.reconstruct_strings!(test) == expected
  end

  test "Reconstruction of strings when there is nothing to do" do
    test = ["Foo"]
    expected = ["Foo"]

    assert Parser.reconstruct_strings!(test) == expected
  end

  test "Reconstruction of more complex things" do
    test = ["'Foo", "bar", "baz'"]
    expected = ["'Foo bar baz'"]

    assert Parser.reconstruct_strings!(test) == expected
  end

end