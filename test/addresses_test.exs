defmodule Lob.AddressesTest do 
  use ExUnit.Case 
  alias Lob.Addresses

  test "create, retrieve, and delete funtions work"do
     assert {:ok, %{
      "id" => id,
      "description" => "Harry - Home",
      "name" => "Harry Zhang",
      "address_line1" => "123 Test Street",
      "address_line2" => "Unit 199",
      "address_city" => "Mountain View",
      "address_state" => "CA",
      "address_zip" => "94084"
    }} = Addresses.create(%{
      description: "Harry - Home",
      name: "Harry Zhang",
      address_line1: "123 Test Street",
      address_line2: "Unit 199",
      address_city: "Mountain View",
      address_state: "CA",
      address_zip: "94084"
    }) 

    assert {:ok, %{"id" => ^id}} = Addresses.retrieve(id)

    assert {:ok, %{"id" => ^id, "deleted" => true}} = Addresses.delete(id)
  end

   test "list_all area mail works" do 
    assert {:ok, %{}} = Addresses.list_all()
  end

  test "list_all area mail (with params) works" do 
    assert {:ok, %{"count" => 1}} = Addresses.list_all(%{limit: 1})
    assert {:ok, %{}} = Addresses.list_all()
    |> IO.inspect
  end
end
