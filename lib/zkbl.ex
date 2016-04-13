defmodule Zkbl do

  def evaluate_lisp(lisp_string) do
    parse_lisp(lisp_string)
    |> interpret_ast
  end

  @doc """
  Turns an input string of Lisp into nested lists ready for parsing.

    ## Examples

      iex> Zkbl.parse_lisp "((foo) bar)"
      {:ok, [["foo"], "bar"]}

      iex> Zkbl.parse_lisp "(kills (corp 'Fweddit'))"
      {:ok, ["kills", ["corp", "'Fweddit'"]]}

      iex> Zkbl.parse_lisp "(kills (alliance 'White Legion.'))"
      {:ok, ["kills", ["alliance","'White Legion.'"]]}

  """
  def parse_lisp(string) do
    String.replace(string, ")", " ) ")
    |> String.replace("(", " ( ")
    |> String.split(" ")
    |> Enum.filter(&(&1 != ""))
    |> Zkbl.Parser.make_sexp
  end

  def interpret_ast(ast) do
    ast
  end
end
