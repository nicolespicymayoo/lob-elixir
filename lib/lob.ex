defmodule Lob do
  @moduledoc """
  Documentation for Lob.
  """
  @api_url "https://api.lob.com/v1/"

  alias Lob.Helpers

  def request(:post, endpoint, data) do
    {:ok, {form_type, form}} = Helpers.transform(data)
    |> IO.inspect
    options = [hackney: [basic_auth: {get_api_key(), ""}]]
    url = Path.join(@api_url, endpoint)
    HTTPoison.post!(url , {form_type, form}, [], options) 
    |> handle_response
  end

  def request(:get, endpoint) do
    url = Path.join(@api_url, endpoint)
    options = [hackney: [basic_auth: {get_api_key(), ""}]]
    HTTPoison.get!(url, [], options)
    |> handle_response
  end

  def request(:delete, endpoint) do 
    url = Path.join(@api_url, endpoint)
    options = [hackney: [basic_auth: {get_api_key(), ""}]]
    HTTPoison.delete!(url, [], options)
    |> handle_response
  end

  defp handle_response(%{status_code: 200, body: body}) do
    { :ok, Poison.Parser.parse!(body) } 
  end
  defp handle_response(%{status_code: _, body: body}) do
    { :error, Poison.Parser.parse!(body) }
  end

  defp get_api_key do
    System.get_env("LOB_API_KEY") || 
    Application.get_env(:lob, :api_key) ||
    raise """ 
      Missing API key
    """
  end

end
