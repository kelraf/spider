defmodule SpiderWeb.ProduceControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.Produces
  alias Spider.Produces.Produce

  @create_attrs %{amount: 42, category: "some category", type: "some type", units: "some units"}
  @update_attrs %{amount: 43, category: "some updated category", type: "some updated type", units: "some updated units"}
  @invalid_attrs %{amount: nil, category: nil, type: nil, units: nil}

  def fixture(:produce) do
    {:ok, produce} = Produces.create_produce(@create_attrs)
    produce
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all produces", %{conn: conn} do
      conn = get conn, produce_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create produce" do
    test "renders produce when data is valid", %{conn: conn} do
      conn = post conn, produce_path(conn, :create), produce: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, produce_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "amount" => 42,
        "category" => "some category",
        "type" => "some type",
        "units" => "some units"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, produce_path(conn, :create), produce: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update produce" do
    setup [:create_produce]

    test "renders produce when data is valid", %{conn: conn, produce: %Produce{id: id} = produce} do
      conn = put conn, produce_path(conn, :update, produce), produce: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, produce_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "amount" => 43,
        "category" => "some updated category",
        "type" => "some updated type",
        "units" => "some updated units"}
    end

    test "renders errors when data is invalid", %{conn: conn, produce: produce} do
      conn = put conn, produce_path(conn, :update, produce), produce: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete produce" do
    setup [:create_produce]

    test "deletes chosen produce", %{conn: conn, produce: produce} do
      conn = delete conn, produce_path(conn, :delete, produce)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, produce_path(conn, :show, produce)
      end
    end
  end

  defp create_produce(_) do
    produce = fixture(:produce)
    {:ok, produce: produce}
  end
end
