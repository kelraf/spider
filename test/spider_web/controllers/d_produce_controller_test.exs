defmodule SpiderWeb.DProduceControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.DProduces
  alias Spider.DProduces.DProduce

  @create_attrs %{category: "some category", reference: "some reference", units: "some units"}
  @update_attrs %{category: "some updated category", reference: "some updated reference", units: "some updated units"}
  @invalid_attrs %{category: nil, reference: nil, units: nil}

  def fixture(:d_produce) do
    {:ok, d_produce} = DProduces.create_d_produce(@create_attrs)
    d_produce
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all dproduces", %{conn: conn} do
      conn = get conn, d_produce_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create d_produce" do
    test "renders d_produce when data is valid", %{conn: conn} do
      conn = post conn, d_produce_path(conn, :create), d_produce: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, d_produce_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "category" => "some category",
        "reference" => "some reference",
        "units" => "some units"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, d_produce_path(conn, :create), d_produce: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update d_produce" do
    setup [:create_d_produce]

    test "renders d_produce when data is valid", %{conn: conn, d_produce: %DProduce{id: id} = d_produce} do
      conn = put conn, d_produce_path(conn, :update, d_produce), d_produce: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, d_produce_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "category" => "some updated category",
        "reference" => "some updated reference",
        "units" => "some updated units"}
    end

    test "renders errors when data is invalid", %{conn: conn, d_produce: d_produce} do
      conn = put conn, d_produce_path(conn, :update, d_produce), d_produce: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete d_produce" do
    setup [:create_d_produce]

    test "deletes chosen d_produce", %{conn: conn, d_produce: d_produce} do
      conn = delete conn, d_produce_path(conn, :delete, d_produce)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, d_produce_path(conn, :show, d_produce)
      end
    end
  end

  defp create_d_produce(_) do
    d_produce = fixture(:d_produce)
    {:ok, d_produce: d_produce}
  end
end
