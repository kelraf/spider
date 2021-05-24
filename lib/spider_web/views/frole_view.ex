defmodule SpiderWeb.FroleView do
  use SpiderWeb, :view
  alias SpiderWeb.FroleView

  def render("index.json", %{froles: froles}) do
    %{data: render_many(froles, FroleView, "frole.json")}
  end

  def render("show.json", %{frole: frole}) do
    %{data: render_one(frole, FroleView, "frole.json")}
  end

  def render("frole.json", %{frole: frole}) do
    %{
      id: frole.id,
      capacity: frole.capacity,
      flight_id: frole.flight_id,
      drole_id: frole.drole_id
    }
  end
end
