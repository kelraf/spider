defmodule SpiderWeb.DReqController do
  use SpiderWeb, :controller

  alias Spider.DReqs
  alias Spider.DReqs.DReq

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    dreqs = DReqs.list_dreqs()
    render(conn, "index.json", dreqs: dreqs)
  end

  def create(conn, %{"d_req" => d_req_params}) do
    with {:ok, %DReq{} = d_req} <- DReqs.create_d_req(d_req_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", d_req_path(conn, :show, d_req))
      |> render("show.json", d_req: d_req)
    end
  end

  def show(conn, %{"id" => id}) do
    d_req = DReqs.get_d_req!(id)
    render(conn, "show.json", d_req: d_req)
  end

  def update(conn, %{"id" => id, "d_req" => d_req_params}) do
    d_req = DReqs.get_d_req!(id)

    with {:ok, %DReq{} = d_req} <- DReqs.update_d_req(d_req, d_req_params) do
      render(conn, "show.json", d_req: d_req)
    end
  end

  def delete(conn, %{"id" => id}) do
    d_req = DReqs.get_d_req!(id)
    with {:ok, %DReq{}} <- DReqs.delete_d_req(d_req) do
      send_resp(conn, :no_content, "")
    end
  end
end
