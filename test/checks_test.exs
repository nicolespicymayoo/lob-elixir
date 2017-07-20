defmodule Lob.ChecksTest do 
  use ExUnit.Case
  alias Lob.Checks

  test "create, retrieve, & delete work" do 
    date = DateTime.utc_now() |> Calendar.Date.next_day!

    assert {:ok, %{
      "id" => id,
      "to" => %{
        "name" => "Harry Zhang",
      }
    }} = Checks.create(%{
      to: %{
        name: "Harry Zhang",
        address_line1: "123 Test Street",
        address_city: "Mountain View",
        address_state: "CA",
        address_zip: "94041",
        address_country: "US",
      },
      from: %{
        name: "Ami Wang",
        address_line1: "123 Test Avenue",
        address_city: "Mountain View",
        address_state: "CA",
        address_zip: "94041",
        address_country: "US",
      },
      bank_account: "bank_5371040a0b87a17",
      amount: 250.00,
      send_date: "#{date}"
    })
    
    assert {:ok, %{
      "id" => ^id,
    }} = Checks.retrieve(id)

    assert {:ok, %{"id" => ^id, "deleted" => true }} = Checks.cancel(id)
  end


  test "list_all works" do
    assert {:ok, %{}} = Checks.list_all()
  end

  test "list_all with optionals param works" do
    assert {:ok, %{"count" => 1}} = Checks.list_all(%{limit: 1})
  end
end