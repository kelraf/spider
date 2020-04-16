defmodule SpiderWeb.VessleView do
  use SpiderWeb, :view
  alias SpiderWeb.VessleView 

  def render("index.json", %{vessles: vessles}) do
    %{data: render_many(vessles, VessleView, "vessle.json")}
  end

  def render("show.json", %{vessle: vessle}) do
    %{data: render_one(vessle, VessleView, "vessle.json")}
  end

  def render("vessle.json", %{vessle: vessle}) do
    %{
      id: vessle.id,
      unique_number: vessle.unique_number,
      status: vessle.status,
      user_id: vessle.user_id,
      business_id: vessle.business_id,
      eroles: render_many(vessle.eroles, VessleView, "e_role.json", as: :e_role)
    }
  end

  def render("e_role.json", %{e_role: e_role}) do
    %{
      id: e_role.id,
      capacity: e_role.capacity,
      vessle_id: e_role.vessle_id,
      drole_id: e_role.drole_id
    }
  end

end
