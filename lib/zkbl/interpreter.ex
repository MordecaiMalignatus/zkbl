defmodule Zkbl.Interpreter do
  @moduledoc """
  This is the central interpreter that makes all the filtering happen.
  """
  alias Zkbl.Sexp


  @spec eval_sexp(Sexp.t) :: {atom, [any]} | {atom, String.t}
  def eval_sexp(sexp) do
    {:error, "Not implemented"}
  end
end