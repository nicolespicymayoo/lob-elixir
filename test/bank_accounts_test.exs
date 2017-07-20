defmodule BankAccountsTest do 
  use ExUnit.Case

  alias Lob.BankAccounts

  test "create, retrieve, delete, & verify works" do
    assert {:ok, %{
      "description" => "Test Bank Account",
      "id" => id
    }} = BankAccounts.create(%{
      description: "Test Bank Account",
      routing_number: "322271627",
      account_number: "123456789",
      signatory: "John Doe",
      account_type: "company"
    })

    assert {:ok, %{
      "description" => "Test Bank Account",
      "id" => ^id,
    }} = BankAccounts.retrieve(id)

    assert {:ok, %{"id" => ^id, "verified" => true}} = BankAccounts.verify(id, amounts: [22, 42])

    assert {:ok, %{"id" => ^id, "deleted" => true }} = BankAccounts.delete(id)
  end


  test "list_all works" do
    assert {:ok, %{}} = BankAccounts.list_all()
  end

  test "list_all with optionals param works" do
    assert {:ok, %{"count" => 1}} = BankAccounts.list_all(%{limit: 1})
  end
end