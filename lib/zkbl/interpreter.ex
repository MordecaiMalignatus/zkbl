defmodule Zkbl.Interpreter do
  @moduledoc """
  This is the central interpreter that makes all the filtering happen.
  """

  @spec interpret_ast({atom, [String.t]}) :: {atom, Hashmap}
  def interpret_ast({:ok, ast}) do
    eval_sexp ast
  end

  def interpret_ast(t = {:error, _}) do
    t
  end

  @spec eval_sexp([String.t]) :: {atom, [any]} | {atom, String.t}
  def eval_sexp(sexp) do
    # Do nested Sexps first
    [func_string | args] = beta_reduce(sexp)
    fun = Zkbl.Stdlib.lookup_function(func_string)

    apply(fun, [args])
  end

  @doc """
  Beta reduction, as in lambda calculus beta reduction, meaning, it recursively
  evaluates every nested function call within,
  """
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