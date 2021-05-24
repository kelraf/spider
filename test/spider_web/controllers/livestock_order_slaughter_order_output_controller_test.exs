defmodule SpiderWeb.LivestockOrderSlaughterOrderOutputControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.LivestockOrderSlaughterOrderOutputs
  alias Spider.LivestockOrderSlaughterOrderOutputs.LivestockOrderSlaughterOrderOutput

  @create_attrs %{output_name: "some output_name", quantity: 42, status: 42, units: "some units"}
  @update_attrs %{output_name: "some updated output_name", quantity: 43, status: 43, units: "some updated units"}
  @invalid_attrs %{output_name: nil, quantity: nil, status: nil, units: nil}

  def fixture(:livestock_order_slaughter_order_output) do
    {:ok, livestock_order_slaughter_order_output} = LivestockOrderSlaughterOrderOutputs.create_livestock_order_slaughter_order_output(@create_attrs)
    livestock_order_slaughter_order_output
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all livestock_order_slaughter_order_outputs", %{conn: conn} do
      conn = get conn, livestock_order_slaughter_order_output_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create livestock_order_slaughter_order_output" do
    test "renders livestock_order_slaughter_order_output when data is valid", %{conn: conn} do
      conn = post conn, livestock_order_slaughter_order_output_path(conn, :create), livestock_order_slaughter_order_output: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, livestock_order_slaughter_order_output_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "output_name" => "some output_name",
        "quantity" => 42,
        "status" => 42,
        "units" => "some units"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, livestock_order_slaughter_order_output_path(conn, :create), livestock_order_slaughter_order_output: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update livestock_order_slaughter_order_output" do
    setup [:create_livestock_order_slaughter_order_output]

    test "renders livestock_order_slaughter_order_output when data is valid", %{conn: conn, livestock_order_slaughter_order_output: %LivestockOrderSlaughterOrderOutput{id: id} = livestock_order_slaughter_order_output} do
      conn = put conn, livestock_order_slaughter_order_output_path(conn, :update, livestock_order_slaughter_order_output), livestock_order_slaughter_order_output: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, livestock_order_slaughter_order_output_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "output_name" => "some updated output_name",
        "quantity" => 43,
        "status" => 43,
        "units" => "some updated units"}
    end

    test "renders errors when data is invalid", %{conn: conn, livestock_order_slaughter_order_output: livestock_order_slaughter_order_output} do
      conn = put conn, livestock_order_slaughter_order_output_path(conn, :update, livestock_order_slaughter_order_output), livestock_order_slaughter_order_output: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete livestock_order_slaughter_order_output" do
    setup [:create_livestock_order_slaughter_order_output]

    test "deletes chosen livestock_order_slaughter_order_output", %{conn: conn, livestock_order_slaughter_order_output: livestock_order_slaughter_order_output} do
      conn = delete conn, livestock_order_slaughter_order_output_path(conn, :delete, livestock_order_slaughter_order_output)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, livestock_order_slaughter_order_output_path(conn, :show, livestock_order_slaughter_order_output)
      end
    end
  end

  defp create_livestock_order_slaughter_order_output(_) do
    livestock_order_slaughter_order_output = fixture(:livestock_order_slaughter_order_output)
    {:ok, livestock_order_slaughter_order_output: livestock_order_slaughter_order_output}
  end
end
