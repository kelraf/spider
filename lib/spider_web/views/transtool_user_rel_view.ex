defmodule SpiderWeb.TranstoolUserRelView do
  use SpiderWeb, :view
  alias SpiderWeb.TranstoolUserRelView

  def render("index.json", %{transtooluserrels: transtooluserrels}) do
    %{data: render_many(transtooluserrels, TranstoolUserRelView, "transtool_user_rel.json")}
  end

  def render("show.json", %{transtool_user_rel: transtool_user_rel}) do
    %{data: render_one(transtool_user_rel, TranstoolUserRelView, "transtool_user_rel.json")}
  end

  def render("transtool_user_rel.json", %{transtool_user_rel: transtool_user_rel}) do
    %{
      id: transtool_user_rel.id,
      user_id: transtool_user_rel.user_id,
      business_id: transtool_user_rel.business_id,
      transtool_id: transtool_user_rel.transtool_id
    }
  end
end
