defmodule SpiderWeb.LivestockController do
  use SpiderWeb, :controller

  alias Spider.Livestocks
  alias Spider.Livestocks.Livestock
  alias Spider.Repo
  alias Spider.TLivestocks

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do

    livestocks = Livestocks.list_livestocks() |> Repo.preload(:tlivestocks)
    render(conn, "index.json", livestocks: livestocks)

  end

  def get_livestocks_using_business_id(conn, %{"business_id" => business_id}) do
    
    case Livestocks.get_livestocks_using_business_id(business_id) do
      {:empty, _nonses} ->
        conn
        |> json(%{
          data: [],
          message: "No Livestocks Related To Your Business."
        })

      {:ok, livestocks} ->
        conn
        |> render("index.json", livestocks: livestocks |> Repo.preload(:tlivestocks))
        
    end

  end

  def create(conn, %{"livestock" => livestock_params}) do

    with {:ok, %Livestock{} = livestock} <- Livestocks.create_livestock(livestock_params) do

      t_livestock = %{
        livestock_id: livestock.id,
        quantity: livestock.quantity
      }

      # Task.start(fn -> TLivestocks.create_t_livestock(t_livestock) end)
      TLivestocks.create_t_livestock(t_livestock)

      conn
      |> put_status(:created)
      |> put_resp_header("location", livestock_path(conn, :show, livestock))
      |> render("show.json", livestock: livestock |> Repo.preload(:tlivestocks))
    end
    
  end

  def show(conn, %{"id" => id}) do

    livestock = Livestocks.get_livestock!(id) |> Repo.preload(:tlivestocks)
    render(conn, "show.json", livestock: livestock)

  end

  def update(conn, %{"id" => id, "livestock" => livestock_params}) do

    livestock = Livestocks.get_livestock!(id)

    with {:ok, %Livestock{} = livestock} <- Livestocks.update_livestock(livestock, livestock_params) do

      t_livestock = %{
        livestock_id: livestock.id,
        quantity: livestock.quantity
      }

      # Task.start(fn -> TLivestocks.create_t_livestock(t_livestock) end)
      TLivestocks.create_t_livestock(t_livestock)

      render(conn, "show.json", livestock: livestock |> Repo.preload(:tlivestocks))

    end

  end

  def delete(conn, %{"id" => id}) do

    livestock = Livestocks.get_livestock!(id)
    with {:ok, %Livestock{}} <- Livestocks.delete_livestock(livestock) do
      send_resp(conn, :no_content, "")
    end

  end
end
