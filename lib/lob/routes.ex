defmodule Lob.Routes do 
  alias Lob.Helpers

  def retrieve(zip_code) do 
    Lob.request(:get, "routes/#{zip_code}" )
  end

  def list_all(zip_codes: zip_codes) when is_list(zip_codes) do 
    query_params = list_all_helper(zip_codes)
    |> IO.inspect
    Lob.request(:get, "routes?#{query_params}")
  end

  defp list_all_helper(zip_codes) do 
    Enum.map(zip_codes, fn zip -> "zip_codes=#{zip}" end)
    |> Enum.join("&")
  end
end