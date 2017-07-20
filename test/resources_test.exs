defmodule ResourcesTest do 
  use ExUnit.Case
  alias Lob.Resources

  test "list all states works" do 
    assert {:ok, %{
      "data" => [
        %{"name" => _} |tail
      ]
    }} = Resources.list_all_states()
  end

    test "list all countries works" do 
    assert {:ok, %{
      "data" => [
        %{"name" => _} |tail
      ]
    }} = Resources.list_all_countries()
  end
end