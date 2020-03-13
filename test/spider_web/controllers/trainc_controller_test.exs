defmodule SpiderWeb.TraincControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.Traincs
  alias Spider.Traincs.Trainc

  @create_attrs %{role: "some role", unique_number: "some unique_number"}
  @update_attrs %{role: "some updated role", unique_number: "some updated unique_number"}
  @invalid_attrs %{role: nil, unique_number: nil}

  def fixture(:trainc) do
    {:ok, trainc} = Traincs.create_trainc(@create_attrs)
    trainc
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all traincs", %{conn: conn} do
      conn = get conn, trainc_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create trainc" do
    test "renders trainc when data is valid", %{conn: conn} do
      conn = post conn, trainc_path(conn, :create), trainc: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, trainc_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "role" => "some role",
        "unique_number" => "some unique_number"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, trainc_path(conn, :create), trainc: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update trainc" do
    setup [:create_trainc]

    test "renders trainc when data is valid", %{conn: conn, trainc: %Trainc{id: id} = trainc} do
      conn = put conn, trainc_path(conn, :update, trainc), trainc: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, trainc_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "role" => "some updated role",
        "unique_number" => "some updated unique_number"}
    end

    test "renders errors when data is invalid", %{conn: conn, trainc: trainc} do
      conn = put conn, trainc_path(conn, :update, trainc), trainc: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete trainc" do
    setup [:create_trainc]

    test "deletes chosen trainc", %{conn: conn, trainc: trainc} do
      conn = delete conn, trainc_path(conn, :delete, trainc)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, trainc_path(conn, :show, trainc)
      end
    end
  end

  defp create_trainc(_) do
    trainc = fixture(:trainc)
    {:ok, trainc: trainc}
  end
end
