defmodule SpiderWeb.ProduceOrderStageControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.ProduceOrderStages
  alias Spider.ProduceOrderStages.ProduceOrderStage

  @create_attrs %{stage_name: "some stage_name", stage_number: 42, status: 42}
  @update_attrs %{stage_name: "some updated stage_name", stage_number: 43, status: 43}
  @invalid_attrs %{stage_name: nil, stage_number: nil, status: nil}

  def fixture(:produce_order_stage) do
    {:ok, produce_order_stage} = ProduceOrderStages.create_produce_order_stage(@create_attrs)
    produce_order_stage
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all produce_order_stages", %{conn: conn} do
      conn = get conn, produce_order_stage_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create produce_order_stage" do
    test "renders produce_order_stage when data is valid", %{conn: conn} do
      conn = post conn, produce_order_stage_path(conn, :create), produce_order_stage: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, produce_order_stage_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "stage_name" => "some stage_name",
        "stage_number" => 42,
        "status" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, produce_order_stage_path(conn, :create), produce_order_stage: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update produce_order_stage" do
    setup [:create_produce_order_stage]

    test "renders produce_order_stage when data is valid", %{conn: conn, produce_order_stage: %ProduceOrderStage{id: id} = produce_order_stage} do
      conn = put conn, produce_order_stage_path(conn, :update, produce_order_stage), produce_order_stage: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, produce_order_stage_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "stage_name" => "some updated stage_name",
        "stage_number" => 43,
        "status" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, produce_order_stage: produce_order_stage} do
      conn = put conn, produce_order_stage_path(conn, :update, produce_order_stage), produce_order_stage: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete produce_order_stage" do
    setup [:create_produce_order_stage]

    test "deletes chosen produce_order_stage", %{conn: conn, produce_order_stage: produce_order_stage} do
      conn = delete conn, produce_order_stage_path(conn, :delete, produce_order_stage)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, produce_order_stage_path(conn, :show, produce_order_stage)
      end
    end
  end

  defp create_produce_order_stage(_) do
    produce_order_stage = fixture(:produce_order_stage)
    {:ok, produce_order_stage: produce_order_stage}
  end
end
