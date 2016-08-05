defmodule Api.XmlTest do
  use ExUnit.Case

  test "Do the requests with args work?" do
    assert Api.Xml.id_for_char_name("Chribba") == "196379789" 
  end
end
