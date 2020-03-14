defmodule SpiderWeb.TransporterView do
  use SpiderWeb, :view
  alias SpiderWeb.TransporterView

  def render("index.json", %{transporters: transporters}) do
    %{data: render_many(transporters, TransporterView, "transporter.json")}
  end

  def render("show.json", %{transporter: transporter}) do
    %{data: render_one(transporter, TransporterView, "transporter.json")}
  end

  def render("transporter.json", %{transporter: transporter}) do
    %{
      id: transporter.id,
      transporter_id: transporter.transporter_id,
      logitude_from: transporter.longitude_from,
      latitude_from: transporter.latitude_from,
      longitude_to: transporter.longitude_to,
      latitude_to: transporter.latitude_to,
      status: transporter.status,
      transporter_container_id: transporter.transporter_container_id,
      mode: transporter.mode
    }
  end
end
