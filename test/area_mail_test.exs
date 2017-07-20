defmodule TestAreaMail do 
  use ExUnit.Case

  alias Lob.AreaMail

  test "create & retrieve areas work" do 
    assert {:ok, %{
      "id" => id,
      "description" => "Test Area",
    }} = AreaMail.create(%{
      description: "Test Area",
      front: "<h1>Demo Area Mail for San Francisco</h1>",
      back: "https://lob.com/areaback.pdf",
      routes: ["94158-C001", "94107-C031"],
    }) 

    assert {:ok, %{"id" => ^id}} = AreaMail.retrieve(id)
  end

  test "list_all area mail works" do 
    assert {:ok, %{"count" => 1}} = AreaMail.list_all(%{limit: 1})
    assert {:ok, %{}} = AreaMail.list_all()
    |> IO.inspect
  end
end