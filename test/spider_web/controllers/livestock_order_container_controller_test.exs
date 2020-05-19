defmodule SpiderWeb.LivestockOrderContainerControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.LivestockOrderContainers
  alias Spider.LivestockOrderContainers.LivestockOrderContainer

  @create_attrs %{channel: "some channel", status: 42, total_cost: "some total_cost"}
  @update_attrs %{channel: "some updated channel", status: 43, total_cost: "some updated total_cost"}
  @invalid_attrs %{channel: nil, status: nil, total_cost: nil}

  def fixture(:livestock_order_container) do
    {:ok, livestock_order_container} = LivestockOrderContainers.create_livestock_order_container(@create_attrs)
    livestock_order_container
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all livestock_order_containers", %{conn: conn} do
      conn = get conn, livestock_order_container_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create livestock_order_container" do
    test "renders livestock_order_container when data is valid", %{conn: conn} do
      conn = post conn, livestock_order_container_path(conn, :create), livestock_order_container: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, livestock_order_container_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "channel" => "some channel",
        "status" => 42,
        "total_cost" => "some total_cost"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, livestock_order_container_path(conn, :create), livestock_order_container: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update livestock_order_container" do
    setup [:create_livestock_order_container]

    test "renders livestock_order_container when data is valid", %{conn: conn, livestock_order_container: %LivestockOrderContainer{id: id} = livestock_order_container} do
      conn = put conn, livestock_order_container_path(conn, :update, livestock_order_container), livestock_order_container: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, livestock_order_container_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "channel" => "some updated channel",
        "status" => 43,
        "total_cost" => "some updated total_cost"}
    end

    test "renders errors when data is invalid", %{conn: conn, livestock_order_container: livestock_order_container} do
      conn = put conn, livestock_order_container_path(conn, :update, livestock_order_container), livestock_order_container: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete livestock_order_container" do
    setup [:create_livestock_order_container]

    test "deletes chosen livestock_order_container", %{conn: conn, livestock_order_container: livestock_order_container} do
      conn = delete conn, livestock_order_container_path(conn, :delete, livestock_order_container)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, livestock_order_container_path(conn, :show, livestock_order_container)
      end
    end
  end

  defp create_livestock_order_container(_) do
    livestock_order_container = fixture(:livestock_order_container)
    {:ok, livestock_order_container: livestock_order_container}
  end
end
