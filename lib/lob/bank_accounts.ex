defmodule Lob.BankAccounts do 

  alias Lob.Helpers

  def create(data) do
    Lob.request(:post, "bank_accounts", data)
  end

  def retrieve(id) do 
    Lob.request(:get, "bank_accounts/#{id}")
  end

  def delete(id) do 
    Lob.request(:delete, "bank_accounts/#{id}")
  end

  def verify(id, amounts: [n1, n2])do
    Lob.request(:post, "bank_accounts/#{id}/verify", amounts: [n1, n2])
  end

  def list_all do
    Lob.request(:get, "bank_accounts")
  end

  def list_all(optionals) do 
    query_params = Helpers.encode_data(optionals)
    Lob.request(:get, "bank_accounts?#{query_params}")
  end

end