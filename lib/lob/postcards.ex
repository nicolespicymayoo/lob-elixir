defmodule Lob.Postcards do
  alias Lob.Helpers

  def create(data) do
    Lob.request(:post, "/postcards",  data)
  end

  def retrieve(id) do
    Lob.request(:get, "/postcards/#{id}")
  end

  def cancel(id) do 
    Lob.request(:delete, "/postcards/#{id}")
  end

  def list_all() do
    Lob.request(:get, "/postcards")
  end

  def list_all(optionals) do 
    query_params = Helpers.encode_data(optionals)
    Lob.request(:get, "/postcards?#{query_params}")
  end

end