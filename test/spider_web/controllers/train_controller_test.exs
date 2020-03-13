defmodule SpiderWeb.TrainControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.Trains
  alias Spider.Trains.Train

  @create_attrs %{role: "some role", unique_number: "some unique_number"}
  @update_attrs %{role: "some updated role", unique_number: "some updated unique_number"}
  @invalid_attrs %{role: nil, unique_number: nil}

  def fixture(:train) do
    {:ok, train} = Trains.create_train(@create_attrs)
    train
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all trains", %{conn: conn} do
      conn = get conn, train_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create train" do
    test "renders train when data is valid", %{conn: conn} do
      conn = post conn, train_path(conn, :create), train: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, train_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "role" => "some role",
        "unique_number" => "some unique_number"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, train_path(conn, :create), train: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update train" do
    setup [:create_train]

    test "renders train when data is valid", %{conn: conn, train: %Train{id: id} = train} do
      conn = put conn, train_path(conn, :update, train), train: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, train_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "role" => "some updated role",
        "unique_number" => "some updated unique_number"}
    end

    test "renders errors when data is invalid", %{conn: conn, train: train} do
      conn = put conn, train_path(conn, :update, train), train: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete train" do
    setup [:create_train]

    test "deletes chosen train", %{conn: conn, train: train} do
      conn = delete conn, train_path(conn, :delete, train)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, train_path(conn, :show, train)
      end
    end
  end

  defp create_train(_) do
    train = fixture(:train)
    {:ok, train: train}
  end
end
