defmodule SpiderWeb.ProduceOrderContainerView do
  use SpiderWeb, :view
  alias SpiderWeb.ProduceOrderContainerView
  alias SpiderWeb.ProduceOrderView
  alias SpiderWeb.UserView

  def render("index.json", %{produce_order_containers: produce_order_containers}) do
    %{data: render_many(produce_order_containers, ProduceOrderContainerView, "produce_order_container.json")}
  end

  def render("show.json", %{produce_order_container: produce_order_container}) do
    %{data: render_one(produce_order_container, ProduceOrderContainerView, "produce_order_container.json")}
  end

  def render("produce_order_container.json", %{produce_order_container: produce_order_container}) do
    %{
      id: produce_order_container.id,
      channel: produce_order_container.channel,
      status: produce_order_container.status,
      business_from_id: produce_order_container.business_from_id,
      payment_status: produce_order_container.payment_status,
      user_id: produce_order_container.user_id,
      business_id: produce_order_container.business_id,
      produce_orders: render_many(produce_order_container.produce_orders, ProduceOrderView, "produce_order.json", as: :produce_order),
      user: render_one(produce_order_container.user, UserView, "user.json", as: :user) |> Map.drop([:pin, :password_hash, :national_id_number])
    }
  end
end
