defmodule Api.XmlTest do
  use ExUnit.Case
  doctest Api.Xml
  alias Api.Xml

  test "Do the requests with args work?" do
    assert Xml.id_for_char_name("Chribba") == "196379789" 
  end

  test "Do multiple char-name request work?" do
    names = ["Chribba", "Squizz Caphinator"]
    expected = ["196379789", "1633218082"]

    assert Xml.id_for_char_name(names) == expected
  end
end
