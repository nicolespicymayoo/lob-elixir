defmodule Lob.AreaMail do
  alias Lob.Helpers

  def create(data) do 
    Lob.request(:post, "areas", data)
  end

  def retrieve(id) do 
    Lob.request(:get, "areas/#{id}")
  end

    def list_all() do
    Lob.request(:get, "areas")
  end

  def list_all(optionals) do 
    query_params = Helpers.encode_data(optionals)
    Lob.request(:get, "areas?#{query_params}")
  end


end