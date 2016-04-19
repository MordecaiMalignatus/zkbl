defmodule Zkbl.Stdlib do
  @moduledoc """
  This module contains the 'standard library' for zkbl. In here reside
  all the functions actually called by the lisp, and those responsible for
  doing all the work after the arguments and the function name has been sorted
  out.
  """

  alias __MODULE__, as: Std

  @lib %{
    "sum" => &Std.sum/1
  }

  @doc """
  A simple abstraction over a map lookup, for the sakes of nicer interface.
  """
  def lookup_function(function_string) do
    case Map.has_key?(@lib, function_string) do
      true -> @lib[function_string]
      false -> raise "Function not found in stdlib: #{function_string}"
    end
  end

  def sum(args) do
    Enum.map(args, &custom_int_parse/1)
    |> Enum.reduce(&(&1 + &2))
  end

  defp custom_int_parse(int_string) do
    {number, _} = Integer.parse(int_string)
    number
  end
end