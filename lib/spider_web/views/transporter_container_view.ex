defmodule SpiderWeb.TransporterContainerView do
  use SpiderWeb, :view
  alias SpiderWeb.TransporterContainerView

  def render("index.json", %{transportercontainer: transportercontainer}) do
    %{data: render_many(transportercontainer, TransporterContainerView, "transporter_container.json")}
  end

  def render("show.json", %{transporter_container: transporter_container}) do
    %{data: render_one(transporter_container, TransporterContainerView, "transporter_container.json")}
  end

  def render("transporter_container.json", %{transporter_container: transporter_container}) do
    %{
      id: transporter_container.id,
      order_id: transporter_container.order_id,
      user_id: transporter_container.user_id,
      business_id: transporter_container.business_id,
      status: transporter_container.status
    }
  end
end
