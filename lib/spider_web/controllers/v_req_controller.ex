defmodule SpiderWeb.VReqController do
  use SpiderWeb, :controller

  alias Spider.VReqs
  alias Spider.VReqs.VReq

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    vreqs = VReqs.list_vreqs()
    render(conn, "index.json", vreqs: vreqs)
  end

  def create(conn, %{"v_req" => v_req_params}) do
    with {:ok, %VReq{} = v_req} <- VReqs.create_v_req(v_req_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", v_req_path(conn, :show, v_req))
      |> render("show.json", v_req: v_req)
    end
  end

  def show(conn, %{"id" => id}) do
    v_req = VReqs.get_v_req!(id)
    render(conn, "show.json", v_req: v_req)
  end

  def update(conn, %{"id" => id, "v_req" => v_req_params}) do
    v_req = VReqs.get_v_req!(id)

    with {:ok, %VReq{} = v_req} <- VReqs.update_v_req(v_req, v_req_params) do
      render(conn, "show.json", v_req: v_req)
    end
  end

  def delete(conn, %{"id" => id}) do
    v_req = VReqs.get_v_req!(id)
    with {:ok, %VReq{}} <- VReqs.delete_v_req(v_req) do
      send_resp(conn, :no_content, "")
    end
  end
end
