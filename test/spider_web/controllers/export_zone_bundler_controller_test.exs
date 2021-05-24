defmodule SpiderWeb.ExportZoneBundlerControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.ExportZoneBundlers
  alias Spider.ExportZoneBundlers.ExportZoneBundler

  @create_attrs %{capacity: 42, size: "some size"}
  @update_attrs %{capacity: 43, size: "some updated size"}
  @invalid_attrs %{capacity: nil, size: nil}

  def fixture(:export_zone_bundler) do
    {:ok, export_zone_bundler} = ExportZoneBundlers.create_export_zone_bundler(@create_attrs)
    export_zone_bundler
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all export_zone_bundler", %{conn: conn} do
      conn = get conn, export_zone_bundler_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create export_zone_bundler" do
    test "renders export_zone_bundler when data is valid", %{conn: conn} do
      conn = post conn, export_zone_bundler_path(conn, :create), export_zone_bundler: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, export_zone_bundler_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "capacity" => 42,
        "size" => "some size"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, export_zone_bundler_path(conn, :create), export_zone_bundler: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update export_zone_bundler" do
    setup [:create_export_zone_bundler]

    test "renders export_zone_bundler when data is valid", %{conn: conn, export_zone_bundler: %ExportZoneBundler{id: id} = export_zone_bundler} do
      conn = put conn, export_zone_bundler_path(conn, :update, export_zone_bundler), export_zone_bundler: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, export_zone_bundler_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "capacity" => 43,
        "size" => "some updated size"}
    end

    test "renders errors when data is invalid", %{conn: conn, export_zone_bundler: export_zone_bundler} do
      conn = put conn, export_zone_bundler_path(conn, :update, export_zone_bundler), export_zone_bundler: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete export_zone_bundler" do
    setup [:create_export_zone_bundler]

    test "deletes chosen export_zone_bundler", %{conn: conn, export_zone_bundler: export_zone_bundler} do
      conn = delete conn, export_zone_bundler_path(conn, :delete, export_zone_bundler)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, export_zone_bundler_path(conn, :show, export_zone_bundler)
      end
    end
  end

  defp create_export_zone_bundler(_) do
    export_zone_bundler = fixture(:export_zone_bundler)
    {:ok, export_zone_bundler: export_zone_bundler}
  end
end
