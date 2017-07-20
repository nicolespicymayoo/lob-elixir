defmodule Lob.Checks do
  alias Lob.Helpers

  def create(data) do 
    Lob.request(:post, "checks", data)
  end

  def retrieve(id) do 
    Lob.request(:get, "checks/#{id}")
  end

  def cancel(id) do
    Lob.request(:delete, "checks/#{id}")
  end

  def list_all() do
    Lob.request(:get, "checks")
  end

  def list_all(optionals) do 
    query_params = Helpers.encode_data(optionals)
    Lob.request(:get, "checks?#{query_params}")
  end
end