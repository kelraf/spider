defmodule SpiderWeb.LivestockOrderProcessingStageControllerTest do
  use SpiderWeb.ConnCase

  alias Spider.LivestockOrderProcessingStages
  alias Spider.LivestockOrderProcessingStages.LivestockOrderProcessingStage

  @create_attrs %{stage_name: "some stage_name", status: 42}
  @update_attrs %{stage_name: "some updated stage_name", status: 43}
  @invalid_attrs %{stage_name: nil, status: nil}

  def fixture(:livestock_order_processing_stage) do
    {:ok, livestock_order_processing_stage} = LivestockOrderProcessingStages.create_livestock_order_processing_stage(@create_attrs)
    livestock_order_processing_stage
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all livestock_order_processing_stages", %{conn: conn} do
      conn = get conn, livestock_order_processing_stage_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create livestock_order_processing_stage" do
    test "renders livestock_order_processing_stage when data is valid", %{conn: conn} do
      conn = post conn, livestock_order_processing_stage_path(conn, :create), livestock_order_processing_stage: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, livestock_order_processing_stage_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "stage_name" => "some stage_name",
        "status" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, livestock_order_processing_stage_path(conn, :create), livestock_order_processing_stage: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update livestock_order_processing_stage" do
    setup [:create_livestock_order_processing_stage]

    test "renders livestock_order_processing_stage when data is valid", %{conn: conn, livestock_order_processing_stage: %LivestockOrderProcessingStage{id: id} = livestock_order_processing_stage} do
      conn = put conn, livestock_order_processing_stage_path(conn, :update, livestock_order_processing_stage), livestock_order_processing_stage: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, livestock_order_processing_stage_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "stage_name" => "some updated stage_name",
        "status" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, livestock_order_processing_stage: livestock_order_processing_stage} do
      conn = put conn, livestock_order_processing_stage_path(conn, :update, livestock_order_processing_stage), livestock_order_processing_stage: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete livestock_order_processing_stage" do
    setup [:create_livestock_order_processing_stage]

    test "deletes chosen livestock_order_processing_stage", %{conn: conn, livestock_order_processing_stage: livestock_order_processing_stage} do
      conn = delete conn, livestock_order_processing_stage_path(conn, :delete, livestock_order_processing_stage)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, livestock_order_processing_stage_path(conn, :show, livestock_order_processing_stage)
      end
    end
  end

  defp create_livestock_order_processing_stage(_) do
    livestock_order_processing_stage = fixture(:livestock_order_processing_stage)
    {:ok, livestock_order_processing_stage: livestock_order_processing_stage}
  end
end
