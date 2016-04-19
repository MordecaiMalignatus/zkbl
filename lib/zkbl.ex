defmodule Zkbl do
  @moduledoc """
  The very top level of the Lisp input. Throw raw Lisp strings here, get
  back ZKB data.
  """

  @doc """
  Your target function for using this library. Throw raw lisp at this, get back
  Hashmaps full of ZKB data.

  ## Examples
    iex> Zkbl.evaluate_lisp "(sum 1 2 3 4)"
    10
  """
  def evaluate_lisp(lisp_string) do
    Zkbl.Parser.parse_lisp(lisp_string)
    |> Zkbl.Interpreter.interpret_ast
  end
end
