defmodule SpiderWeb.TranstoolView do
  use SpiderWeb, :view
  alias SpiderWeb.TranstoolView

  def render("index.json", %{transtools: transtools}) do
    %{data: render_many(transtools, TranstoolView, "transtool.json")}
  end

  def render("show.json", %{transtool: transtool}) do
    %{data: render_one(transtool, TranstoolView, "transtool.json")}
  end

  def render("transtool.json", %{transtool: transtool}) do
    %{id: transtool.id,
      registration_number: transtool.registration_number,
      brand: transtool.brand,
      model: transtool.model,
      type: transtool.type}
  end
end
