defmodule Api.Xml do
  @url_root "https://api.eveonline.com/"
  @headers %{
    "User-Agent" => "Zkbl/0.1 github.com/az4reus/zkbl"
  }

  def request_uri(uri) do
    HTTPoison.get(@url_root <> uri, @headers)
  end

  def parse_response(%HTTPoison.Response{status_code: 200, body: body}) do
    {doc, []} = body
    |> String.to_char_list
    |> :xmerl_scan.string([quiet: true])

    doc
  end

  def parse_response(%HTTPoison.Response{status_code: 404}) do
    {:error, "404"}
  end

  def parse_response(%HTTPoison.Response{status_code: 500}) do
    {:error, "500, you broke it."}
  end
end