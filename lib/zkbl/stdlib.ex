defmodule Zkbl.Stdlib do
  @moduledoc """
  This module contains the 'standard library' for zkbl. In here reside
  all the functions actually called by the lisp, and those responsible for
  doing all the work after the arguments and the function name has been sorted
  out.
  """

  alias __MODULE__, as: Std

  @lib %{
    "sum" => &Std.sum/1,
    "killmail" => &Std.get_kill/1
  }

  @doc """
  This looks up the function string you want from the actual implementation of the
  stdlib.
  """
  def lookup_function(function_string) do
    case Map.has_key?(@lib, function_string) do
      true -> @lib[function_string]
      false -> raise "Function not found in stdlib: #{function_string}"
    end
  end

  @doc """
  Tries to convert all of its arguments to numbers, then sums them all up.
  Will fail on cast if it's arguments are not parsable.

  ## Examples
    iex> Zkbl.evaluate_lisp "(sum 1 2 3 4)"
    10
  """
  def sum(args) do
    Enum.map(args, &custom_int_parse/1)
    |> Enum.reduce(&(&1 + &2))
  end

  @doc """
  TODO
  Az fix this you dumb nerd.
  """
  def get_kill(args) do
    args
    |> Enum.map(&custom_int_parse/1)
    |> Enum.map(&Api.Zkb.get_kill/1)
  end

  defp custom_int_parse(int_string) do
    {number, _} = Integer.parse(int_string)
    number
  end
end
