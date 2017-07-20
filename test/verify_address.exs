defmodule VerifyAddressTest do 
  use ExUnit.Case
  alias Lob.VerifyAddress

  test "us verification function works" do 
    assert {:ok, %{
      "components" => %{
        "city" => "SAN FRANCISCO",
        "zip_code" => "94107"
      }
    }} = VerifyAddress.us(%{
      primary_line: "185 Berry Street",
      city: "San Francisco",
      state: "CA",
      zip_code: "94107"
    })
  end

    test "international verification function works" do 
    assert {:ok, %{
      "components" => %{
        "city" => "SUMMERSIDE",
        "zip_code" => "C1N 1C4"
      }
    }} = VerifyAddress.international(%{
       address_line1:   "370 Water St",
        address_city:    "Summerside",
        address_state:   "Prince Edward Island",
        address_zip:     "C1N 1C4",
        address_country: "CA"
    })
  end

 end 