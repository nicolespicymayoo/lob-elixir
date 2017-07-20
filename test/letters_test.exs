defmodule Lob.LettersTest do 
  use ExUnit.Case

alias Lob.Letters

  test "Letter.create parses object & sends to Lob, then uses ID key to test Letter.retrieve & Letter.delete" do
    date = DateTime.utc_now() |> Calendar.Date.next_day!
    #used in delete function. send_date must be after delete function is called

    assert {:ok, %{
      "id" => id,
      "description" => "Demo Letter",
      "from" => %{
        "name" => "Ami Wang"
      }
    }}
     = Letters.create(%{
      description: "Demo Letter",
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
      file: "<html style=\"padding-top: 3in; margin: .5in;\">HTML Letter for Harry</html>",
      merge_variables: %{
        name: "Harry"
      },
      send_date: "#{date}",
      color: true
    })
    
    assert {:ok, %{"id" => ^id}} = Letters.retrieve(id)

    assert {:ok, %{"id" => ^id, "deleted" => true } }= Letters.cancel(id)
    # the "send_date" option in Letters.create must be after the delete date
  end

  test "list_all function works" do
    assert {:ok, %{
      "count" => _ ,
      "data" => _
    }}
     = Letters.list_all(%{color: true})
  end
end