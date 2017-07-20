defmodule Lob.Letters do 
  alias Lob.Helpers

  def create(data) do 
    Lob.request(:post, "letters", data)
  end

  def retrieve(id) do
    Lob.request(:get, "letters/#{id}")
  end

  def cancel(id) do 
    Lob.request(:delete, "letters/#{id}")
  end 

    def list_all() do 
    Lob.request(:get, "letters")
  end
  def list_all(optionals) do 
    query_params = Helpers.encode_data(optionals)
    Lob.request(:get, "letters?#{query_params}")
  end
end