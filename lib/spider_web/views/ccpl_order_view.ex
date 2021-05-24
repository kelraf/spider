defmodule SpiderWeb.CCPLOrderView do
  use SpiderWeb, :view
  alias SpiderWeb.CCPLOrderView

  def render("index.json", %{c_c_p_l_orders: c_c_p_l_orders}) do
    %{data: render_many(c_c_p_l_orders, CCPLOrderView, "ccpl_order.json")}
  end

  def render("show.json", %{ccpl_order: ccpl_order}) do
    %{data: render_one(ccpl_order, CCPLOrderView, "ccpl_order.json")}
  end

  def render("ccpl_order.json", %{ccpl_order: ccpl_order}) do
    %{
      id: ccpl_order.id,
      purpose: ccpl_order.purpose,
      file: ccpl_order.file,
      uuid: ccpl_order.uuid
    }
  end
end
