defmodule Lob.Resources do

  def list_all_states do
    Lob.request(:get, "states")
  end

  def list_all_countries do 
    Lob.request(:get, "countries")
  end
end