defmodule Lob.PostcardsTest do 
  use ExUnit.Case
  alias Lob.Postcards

  test "create, retrieve, & delete postcard works" do
    date = DateTime.utc_now() |> Calendar.Date.next_day!
    #used in delete funtion. send_date must be after delete function is called

    assert {:ok,%{
      "id" => id, 
      "description" => "Demo Postcard",
      "to" => %{
        "address_city" => "Mountain View",
      }
    }} = Postcards.create(%{
      description: "Demo Postcard",
      to: %{
        name: "Harry Zhang",
        address_line1: "123 Test Street",
        address_city: "Mountain View",
        address_state: "CA",
        address_zip: "94041",
      },
      front: "<html style=\"padding: 1in; font-size: 50;\">Front HTML for</html>",
      message: "hello!",
      send_date: "#{date}"
    })

    assert {:ok, %{ "id" => ^id }} = Postcards.retrieve(id)

    assert {:ok, %{"id" => ^id, "deleted" => true }} = Postcards.cancel(id)
  end

  test "list_all function works" do
    assert {:ok, %{
      "count" => _ ,
      "data" => _
    }}
     = Postcards.list_all()
    end

end