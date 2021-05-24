defmodule SpiderWeb.DLivestockSlaughterOutputControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.DLivestockSlaughterOutputs
  alias Spider.DLivestockSlaughterOutputs.DLivestockSlaughterOutput

  @create_attrs %{checked: true, output_name: "some output_name", units: 42}
  @update_attrs %{checked: false, output_name: "some updated output_name", units: 43}
  @invalid_attrs %{checked: nil, output_name: nil, units: nil}

  def fixture(:d_livestock_slaughter_output) do
    {:ok, d_livestock_slaughter_output} = DLivestockSlaughterOutputs.create_d_livestock_slaughter_output(@create_attrs)
    d_livestock_slaughter_output
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all d_livestock_slaughter_outputs", %{conn: conn} do
      conn = get conn, d_livestock_slaughter_output_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create d_livestock_slaughter_output" do
    test "renders d_livestock_slaughter_output when data is valid", %{conn: conn} do
      conn = post conn, d_livestock_slaughter_output_path(conn, :create), d_livestock_slaughter_output: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, d_livestock_slaughter_output_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "checked" => true,
        "output_name" => "some output_name",
        "units" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, d_livestock_slaughter_output_path(conn, :create), d_livestock_slaughter_output: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update d_livestock_slaughter_output" do
    setup [:create_d_livestock_slaughter_output]

    test "renders d_livestock_slaughter_output when data is valid", %{conn: conn, d_livestock_slaughter_output: %DLivestockSlaughterOutput{id: id} = d_livestock_slaughter_output} do
      conn = put conn, d_livestock_slaughter_output_path(conn, :update, d_livestock_slaughter_output), d_livestock_slaughter_output: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, d_livestock_slaughter_output_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "checked" => false,
        "output_name" => "some updated output_name",
        "units" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, d_livestock_slaughter_output: d_livestock_slaughter_output} do
      conn = put conn, d_livestock_slaughter_output_path(conn, :update, d_livestock_slaughter_output), d_livestock_slaughter_output: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete d_livestock_slaughter_output" do
    setup [:create_d_livestock_slaughter_output]

    test "deletes chosen d_livestock_slaughter_output", %{conn: conn, d_livestock_slaughter_output: d_livestock_slaughter_output} do
      conn = delete conn, d_livestock_slaughter_output_path(conn, :delete, d_livestock_slaughter_output)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, d_livestock_slaughter_output_path(conn, :show, d_livestock_slaughter_output)
      end
    end
  end

  defp create_d_livestock_slaughter_output(_) do
    d_livestock_slaughter_output = fixture(:d_livestock_slaughter_output)
    {:ok, d_livestock_slaughter_output: d_livestock_slaughter_output}
  end
end
