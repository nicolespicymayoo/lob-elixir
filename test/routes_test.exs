defmodule Lob.RoutesTest do 
  use ExUnit.Case
  alias Lob.Routes

  test "retrieve function works" do 
    assert {:ok, %{
      "routes" => [%{"route" => "C002"}],
      "zip_code" => "94158"
    }} = Routes.retrieve("94158-C002")
  end

  test "list_all function works" do
    assert {:ok, %{"data" => [%{"routes" => _} | _tail]}}
    = Routes.list_all(zip_codes: ["48168", "94158"])
  end

end