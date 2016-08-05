defmodule Api.Zkb do
  # TODO: This needs to be fanned out to processes.
  @url_root "https://zkillboard.com/api"
  @headers %{
    "Accept-Encoding" => "gzip",
    "User-Agent" => "Zkbl/0.1 github.com/az4reus/zkbl"
  }

  @doc """
  Retrieves a singular killID from ZKB.
  Warning: This gets really inefficient real quick, it's a HTTP request
  per killID. Do not map this function over collections.
  """
  def get_kill(kill_id) do
    get_uri("/killID/#{kill_id}/")
    |> parse_response
  end

  @doc """
  This is the general-purpose ZKB http getting function, to save typing.

  TODO maybe needs differentiation between gzipped content and non-zipped responses.
  """
  def get_uri(uri) do
    response = HTTPoison.get!(@url_root <> uri, @headers)
    %HTTPoison.Response{response | :body => :zlib.gunzip(response.body)}
  end

  @doc """
  The response parser for HTTPoison responses. Automatically sorts things out
  and only returns :ok when the server replied with 200.
  """
  def parse_response(%HTTPoison.Response{status_code: 200, body: []}) do
    {:error, "Reqeusted Resource not found"}
  end

  def parse_response(%HTTPoison.Response{status_code: 200, body: body}) do
    Poison.Parser.parse(body)
  end

  def parse_response(%HTTPoison.Response{status_code: 404}) do
    {:error, "Requested URL 404'd"}
  end
end
