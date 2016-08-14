defmodule Api.Xml do
  require Record
  Record.defrecord :xmlAttribute, Record.extract(:xmlAttribute, from_lib: "xmerl/include/xmerl.hrl")

  @url_root "https://api.eveonline.com/"
  @headers %{
    "User-Agent" => "Zkbl/0.1 github.com/az4reus/zkbl"
  }

  @doc """
  Turns character names into IDs. As straight forward as it sounds. Do beware, makes one HTTP request
  per function call, if there is a large collection of names to be turned into IDs, pass a list, which
  is also one HTTP call. Mapping this function is inefficient.

  ## Examples
  iex> Api.Xml.id_for_char_name "Chribba"
  "196379789"
  """
  @spec id_for_char_name([String.t]) :: [String.t]
  def id_for_char_name(char_names) when is_list(char_names) do
    xml = request_uri("/eve/characterID.xml.aspx", names: Enum.join(char_names, ","))
    :xmerl_xpath.string('//result/rowset/row/@characterID', xml)
    |> Enum.map(&extract_attribute/1)
  end

  @spec id_for_char_name(String.t) :: String.t
  def id_for_char_name(char_name) do
    xml = request_uri("/eve/characterID.xml.aspx", names: char_name)
    :xmerl_xpath.string('//result/rowset/row/@characterID', xml)
    |> extract_attribute
  end

  def get_character_info(character_id) when is_binary(character_id) do
    xml = request_uri("/eve/CharacterInfo.xml.aspx", character_id: character_id)
    :xmerl_xpath.string('//result/', xml)
  end

  def get_character_info(character_id) when is_integer(character_id) do
    Integer.to_string(character_id)
    |> get_character_info
  end

  def get_character_info(character_id, key_id, v_code) when is_binary(character_id) and is_binary(key_id) do

  end
  
  defp extract_attribute([xmlAttribute(value: value)]), do: List.to_string(value)
  defp extract_attribute(xmlAttribute(value: value)), do: List.to_string(value) 
  defp extract_attribute(_), do: nil
    
  ## Internal API functions that are abstracted over. 

  def request_uri(uri) do
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
