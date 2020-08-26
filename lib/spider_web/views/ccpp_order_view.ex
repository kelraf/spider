defmodule SpiderWeb.CCPPOrderView do
  use SpiderWeb, :view
  alias SpiderWeb.CCPPOrderView

  def render("index.json", %{c_c_p_p_orders: c_c_p_p_orders}) do
    %{data: render_many(c_c_p_p_orders, CCPPOrderView, "ccpp_order.json")}
  end

  def render("show.json", %{ccpp_order: ccpp_order}) do
    %{data: render_one(ccpp_order, CCPPOrderView, "ccpp_order.json")}
  end

  def render("ccpp_order.json", %{ccpp_order: ccpp_order}) do
    %{
      id: ccpp_order.id,
      purpose: ccpp_order.purpose,
      file: ccpp_order.file,
      uuid: ccpp_order.uuid
    }
  end
end
