defmodule SpiderWeb.DReqView do
  use SpiderWeb, :view
  alias SpiderWeb.DReqView

  def render("index.json", %{dreqs: dreqs}) do
    %{data: render_many(dreqs, DReqView, "d_req.json")}
  end

  def render("show.json", %{d_req: d_req}) do
    %{data: render_one(d_req, DReqView, "d_req.json")}
  end

  def render("d_req.json", %{d_req: d_req}) do
    %{id: d_req.id,
      requirement: d_req.requirement}
  end
end
