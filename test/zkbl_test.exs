defmodule ZkblTest do
  use ExUnit.Case
  doctest Zkbl

  alias Zkbl.Parser

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "tokenification" do
   str = "(test)"
   expected = ["test"]

   assert Parser.parse_lisp(str) == {:ok, expected}
  end

  test "tokenification of right-nested sexps" do
    str = "(test (another-test args1))"
    expected = ["test", ["another-test", "args1"]]

    assert Parser.parse_lisp(str) == {:ok, expected}

    str = "(terrible (terrible (terrible (damage))))"
    expected = ["terrible", ["terrible", ["terrible", ["damage"]]]]

    assert Parser.parse_lisp(str) == {:ok, expected}
  end

  test "tokenification of left-nested sexps" do
    str = "((((foobar) foo) bar) qux)"
    expected = [[[["foobar"], "foo"], "bar"], "qux"]

    assert Parser.parse_lisp(str) == {:ok, expected}
  end

  test "tokenification of complex-ish expressions" do
    str = "(any (kills 'foo') (region :vale))"
    expected = ["any", ["kills", "'foo'"], ["region", ":vale"]]

    assert Parser.parse_lisp(str) == {:ok, expected}
  end

end