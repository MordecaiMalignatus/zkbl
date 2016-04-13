defmodule ZkblTest do
  use ExUnit.Case
  doctest Zkbl

  test "the truth" do
    assert 1 + 1 == 2
  end

 test "tokenification" do
   str = "(test)"
   expected = ["test"]

   assert Zkbl.parse_lisp(str) == {:ok, expected}
 end

 test "tokenification of right-nested sexps" do
   str = "(test (another-test args1))"
   expected = ["test", ["another-test", "args1"]]

   assert Zkbl.parse_lisp(str) == {:ok, expected}

   str = "(terrible (terrible (terrible (damage))))"
   expected = ["terrible", ["terrible", ["terrible", ["damage"]]]]

   assert Zkbl.parse_lisp(str) == {:ok, expected}
 end

 test "tokenification of left-nested sexps" do
   str = "((((foobar) foo) bar) qux)"
   expected = [[[["foobar"], "foo"], "bar"], "qux"]

   assert Zkbl.parse_lisp(str) == {:ok, expected}
 end

  test "tokenification of complex-ish expressions" do
    str = "(any (kills 'foo') (region :vale))"
    expected = ["any", ["kills", "'foo'"], ["region", ":vale"]]

    assert Zkbl.parse_lisp(str) == {:ok, expected}
  end

  test "Reconstruction of simple strings" do
    test = ["'foo", "bar'"]
    expected = ["'foo bar'"]

    assert Zkbl.reconstruct_strings!(test) == expected
  end

  test "Reconstruction of strings when there is nothing to do" do
    test = ["Foo"]
    expected = ["Foo"]

    assert Zkbl.reconstruct_strings!(test) == expected
  end

  test "Reconstruction of more complex things" do
    test = ["'Foo", "bar", "baz'"]
    expected = ["'Foo bar baz'"]

    assert Zkbl.reconstruct_strings!(test) == expected
  end
end