defmodule SpiderWeb.OrderContainerView do
  use SpiderWeb, :view
  alias SpiderWeb.OrderContainerView

  def render("index.json", %{ordercontainers: ordercontainers}) do
    %{data: render_many(ordercontainers, OrderContainerView, "order_container.json")}
  end

  def render("show.json", %{order_container: order_container}) do
    %{data: render_one(order_container, OrderContainerView, "order_container.json")}
  end

  def render("order_container.json", %{order_container: order_container}) do
    %{
      id: order_container.id,
      user_id: order_container.user_id,
      business_id: order_container.business_id,
      status: order_container.status,
      total_cost: order_container.total_cost
    }
  end
end
