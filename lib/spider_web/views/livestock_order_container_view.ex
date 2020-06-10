defmodule SpiderWeb.LivestockOrderContainerView do
  use SpiderWeb, :view
  alias SpiderWeb.LivestockOrderContainerView
  alias SpiderWeb.LivestockOrderView
  alias SpiderWeb.UserView

  def render("index.json", %{livestock_order_containers: livestock_order_containers}) do
    %{
      data:
        render_many(
          livestock_order_containers,
          LivestockOrderContainerView,
          "livestock_order_container.json"
        )
    }
  end

  def render("show.json", %{livestock_order_container: livestock_order_container}) do
    %{
      data:
        render_one(
          livestock_order_container,
          LivestockOrderContainerView,
          "livestock_order_container.json"
        )
    }
  end

  def render("livestock_order_container.json", %{
        livestock_order_container: livestock_order_container
      }) do
    %{
      id: livestock_order_container.id,
      status: livestock_order_container.status,
      channel: livestock_order_container.channel,
      user_id: livestock_order_container.user_id,
      business_from_id: livestock_order_container.business_from_id,
      business_id: livestock_order_container.business_id,
      payment_status: livestock_order_container.payment_status,
      user:
        render_one(livestock_order_container.user, UserView, "user.json", as: :user)
        |> Map.drop([:pin, :password_hash, :national_id_number]),
      livestock_orders:
        render_many(
          livestock_order_container.livestock_orders,
          LivestockOrderView,
          "livestock_order.json",
          as: :livestock_order
        )
    }
  end
end
