defmodule Lob.VerifyAddress do 
  
  def us(data) do 
    Lob.request(:post, "/us_verifications", data)
  end

  def international(data) do 
    Lob.request(:post, "/intl_verifications", data)
  end
end