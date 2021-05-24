defmodule SpiderWeb.ProduceOrderContainerControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.ProduceOrderContainers
  alias Spider.ProduceOrderContainers.ProduceOrderContainer

  @create_attrs %{business_from_id: 42, channel: "some channel", payment_status: "some payment_status", status: 42}
  @update_attrs %{business_from_id: 43, channel: "some updated channel", payment_status: "some updated payment_status", status: 43}
  @invalid_attrs %{business_from_id: nil, channel: nil, payment_status: nil, status: nil}

  def fixture(:produce_order_container) do
    {:ok, produce_order_container} = ProduceOrderContainers.create_produce_order_container(@create_attrs)
    produce_order_container
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all produce_order_containers", %{conn: conn} do
      conn = get conn, produce_order_container_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create produce_order_container" do
    test "renders produce_order_container when data is valid", %{conn: conn} do
      conn = post conn, produce_order_container_path(conn, :create), produce_order_container: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, produce_order_container_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "business_from_id" => 42,
        "channel" => "some channel",
        "payment_status" => "some payment_status",
        "status" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, produce_order_container_path(conn, :create), produce_order_container: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update produce_order_container" do
    setup [:create_produce_order_container]

    test "renders produce_order_container when data is valid", %{conn: conn, produce_order_container: %ProduceOrderContainer{id: id} = produce_order_container} do
      conn = put conn, produce_order_container_path(conn, :update, produce_order_container), produce_order_container: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, produce_order_container_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "business_from_id" => 43,
        "channel" => "some updated channel",
        "payment_status" => "some updated payment_status",
        "status" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, produce_order_container: produce_order_container} do
      conn = put conn, produce_order_container_path(conn, :update, produce_order_container), produce_order_container: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete produce_order_container" do
    setup [:create_produce_order_container]

    test "deletes chosen produce_order_container", %{conn: conn, produce_order_container: produce_order_container} do
      conn = delete conn, produce_order_container_path(conn, :delete, produce_order_container)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, produce_order_container_path(conn, :show, produce_order_container)
      end
    end
  end

  defp create_produce_order_container(_) do
    produce_order_container = fixture(:produce_order_container)
    {:ok, produce_order_container: produce_order_container}
  end
end
