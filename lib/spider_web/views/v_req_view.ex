defmodule SpiderWeb.VReqView do
  use SpiderWeb, :view
  alias SpiderWeb.VReqView

  def render("index.json", %{vreqs: vreqs}) do
    %{data: render_many(vreqs, VReqView, "v_req.json")}
  end

  def render("show.json", %{v_req: v_req}) do
    %{data: render_one(v_req, VReqView, "v_req.json")}
  end

  def render("v_req.json", %{v_req: v_req}) do
    %{id: v_req.id,
      available: v_req.available}
  end
end
