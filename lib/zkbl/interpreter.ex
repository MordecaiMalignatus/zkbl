defmodule Zkbl.Interpreter do
  @moduledoc """
  This is the central interpreter that makes all the filtering happen.
  """

  def interpret_ast({:ok, ast}) do
    ast
  end

  def interpret_ast(t = {:error, _}) do
    t
  end

  @spec eval_sexp([String.t]) :: {atom, [any]} | {atom, String.t}
  def eval_sexp(sexp) do
    # Do nested Sexps first
    reduced = beta_reduce(sexp)
    [function | args] = reduced

  end

  @spec beta_reduce([String.t]) :: any
  def beta_reduce(sexp) do
    Enum.map(sexp, fn arg ->
      cond do
        is_list(arg) -> eval_sexp(arg)
        true         -> arg
      end
    end)
  end

end