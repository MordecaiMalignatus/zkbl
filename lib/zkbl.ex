defmodule Zkbl do

  @type sexp :: [String.t]

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

  """
  def parse_lisp(string) do
    String.replace(string, ")", " ) ")
    |> String.replace("(", " ( ")
    |> String.split(" ")
    |> Enum.filter(&(&1 != ""))
    |> make_sexp
  end

  @doc """
  Takes a flat list of tokens, returns nested list that represent order
  and depth of the input lisp expression.

  ## Examples

    iex> Zkbl.make_sexp(["(", "foo", ")"])
    {:ok, ["foo"]}

    iex> Zkbl.make_sexp(["(", "foo", "(", "bar", ")", ")"])
    {:ok, ["foo", ["bar"]]}

  """
  @spec make_sexp([String.t]) :: {atom, sexp} | {atom, String.t}
  def make_sexp(["(" | tail]) do
    {result, _} = make_sexp_acc(tail, [])
    {:ok, result}
  end

  def make_sexp([_ | _]) do
    {:error, "Not a Lisp Expression. Must start with an open parens: '('"}
  end

  def make_sexp(_) do
    {:error, "Must pass a list in order to actually parse lisp."}
  end

  @spec make_sexp_acc([String.t], [String.t]) :: {[String.t], [String.t]}
  defp make_sexp_acc(["("| tail], acc) do
    {inner, leftovers} = make_sexp_acc(tail, [])
    make_sexp_acc(leftovers, acc ++ [inner])
  end

  defp make_sexp_acc([")"|tail], acc) do
    {acc, tail}
  end

  defp make_sexp_acc([head | tail], acc) do
    make_sexp_acc(tail, acc ++ [head])
  end

  @doc """
  This function reconstructs the strings between '' or "" that got broken during
  my naive tokenification.

    ## Examples
    iex> Zkbl.reconstruct_strings ["'Foo", "Bar'"]
    ["'Foo Bar'"]

    iex> Zkbl.reconstruct_strings ["'Terrible", "Terrible", "Damage'"]
    ["'Terrible Terrible Damage'"]
  """
  @spec reconstruct_strings([String.t]) :: [String.t]
  def reconstruct_strings(ast) do
    ast
  end

  def interpret_ast(ast) do
    ast
  end
end
