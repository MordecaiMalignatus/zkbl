defmodule Api.XmlTest do
  use ExUnit.Case

  test "Do the requests with args work?" do
    Api.Xml.id_for_char_name("Chribba")
  end
end
