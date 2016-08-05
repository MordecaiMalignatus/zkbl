defmodule Api.Xml do
  require Record
  Record.defrecord :xmlAttribute, Record.extract(:xmlAttribute, from_lib: "xmerl/include/xmerl.hrl")

  @url_root "https://api.eveonline.com/"
  @headers %{
    "User-Agent" => "Zkbl/0.1 github.com/az4reus/zkbl"
  }

  def id_for_char_name(char_name) do
    xml = request_uri("/eve/characterID.xml.aspx", names: char_name)
    :xmerl_xpath.string('//result/rowset/row/@characterID', xml)
    |> extract_attribute
  end

  defp extract_attribute([xmlAttribute(value: value)]) do
    List.to_string(value)
  end
  defp extract_attribute(_), do: nil
    
  ## Internal API functions that are abstracted over. 

  defp request_uri(uri) do
    HTTPoison.get(@url_root <> uri, @headers)
    |> parse_response
  end

  defp request_uri(uri, params) do
    HTTPoison.get!(@url_root <> uri, @headers, [params: params])
    |> parse_response
  end
  
  defp parse_response(%HTTPoison.Response{status_code: 200, body: body}) do
    {xml, _rest} = :xmerl_scan.string(to_char_list(body))
    xml
  end

  defp parse_response(%HTTPoison.Response{status_code: 404}) do
    {:error, "404"}
  end

  defp parse_response(%HTTPoison.Response{status_code: 500}) do
    {:error, "500, you broke it."}
  end
end
