defmodule SpiderWeb.LivestockController do
  use SpiderWeb, :controller

  alias Spider.Livestocks
  alias Spider.Livestocks.Livestock

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    livestocks = Livestocks.list_livestocks()
    render(conn, "index.json", livestocks: livestocks)
  end

  def get_livestocks_using_business_id(conn, %{"business_id" => business_id}) do
    
    case Livestocks.get_livestocks_using_business_id(business_id) do
      {:empty, _nonses} ->
        conn
        |> json(%{
          message: "No Livestocks Related To Your Business"
        })

      {:ok, livestocks} ->
        conn
        |> render("index.json", livestocks: livestocks)
        
    end

  end

  def create(conn, %{"livestock" => livestock_params}) do
    with {:ok, %Livestock{} = livestock} <- Livestocks.create_livestock(livestock_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", livestock_path(conn, :show, livestock))
      |> render("show.json", livestock: livestock)
    end
  end

  def show(conn, %{"id" => id}) do
    livestock = Livestocks.get_livestock!(id)
    render(conn, "show.json", livestock: livestock)
  end

  def update(conn, %{"id" => id, "livestock" => livestock_params}) do
    livestock = Livestocks.get_livestock!(id)

    with {:ok, %Livestock{} = livestock} <- Livestocks.update_livestock(livestock, livestock_params) do
      render(conn, "show.json", livestock: livestock)
    end
  end

  def delete(conn, %{"id" => id}) do
    livestock = Livestocks.get_livestock!(id)
    with {:ok, %Livestock{}} <- Livestocks.delete_livestock(livestock) do
      send_resp(conn, :no_content, "")
    end
  end
end
