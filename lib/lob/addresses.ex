defmodule Lob.Addresses do
  alias Lob.Helpers

  def create(data) do 
    Lob.request(:post, "addresses", data)
  end

  def retrieve(id) do 
    Lob.request(:get, "addresses/#{id}")
  end

  def delete(id) do 
    Lob.request(:delete, "addresses/#{id}")
  end

  def list_all() do
    Lob.request(:get, "addresses")
  end

  def list_all(optionals) do 
    query_params = Helpers.encode_data(optionals)
    Lob.request(:get, "addresses?#{query_params}")
  end
end