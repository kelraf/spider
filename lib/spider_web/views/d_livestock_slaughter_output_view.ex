defmodule SpiderWeb.DLivestockSlaughterOutputView do
  use SpiderWeb, :view
  alias SpiderWeb.DLivestockSlaughterOutputView

  def render("index.json", %{d_livestock_slaughter_outputs: d_livestock_slaughter_outputs}) do
    %{data: render_many(d_livestock_slaughter_outputs, DLivestockSlaughterOutputView, "d_livestock_slaughter_output.json")}
  end

  def render("show.json", %{d_livestock_slaughter_output: d_livestock_slaughter_output}) do
    %{data: render_one(d_livestock_slaughter_output, DLivestockSlaughterOutputView, "d_livestock_slaughter_output.json")}
  end

  def render("d_livestock_slaughter_output.json", %{d_livestock_slaughter_output: d_livestock_slaughter_output}) do
    %{
      id: d_livestock_slaughter_output.id,
      output_name: d_livestock_slaughter_output.output_name,
      units: d_livestock_slaughter_output.units,
      checked: d_livestock_slaughter_output.checked
    }
  end
end
