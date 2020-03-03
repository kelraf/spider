defmodule SpiderWeb.BusinessController do
  use SpiderWeb, :controller

  alias Spider.Businesses
  alias Spider.Businesses.Business

  action_fallback(SpiderWeb.FallbackController)

  def index(conn, _params) do
    businesses = Businesses.list_businesses()
    render(conn, "index.json", businesses: businesses)
  end

  def get_businesses_using_user_id(conn, %{"user_id" => user_id}) do

    case Businesses.get_businesses_using_user_id(user_id) do
      {:empty, message} ->
        conn
        |> json(%{
          message: message
        })

      {:ok, businesses} ->
        conn
        |> render("index.json", businesses: businesses)
    end
    
  end

  def create(conn, %{"business" => business_params}) do
    with {:ok, %Business{} = business} <- Businesses.create_business(business_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", business_path(conn, :show, business))
      |> render("show.json", business: business)
    end
  end

  def show(conn, %{"id" => id}) do
    business = Businesses.get_business!(id)
    render(conn, "show.json", business: business)
  end

  def update(conn, %{"id" => id, "business" => business_params}) do
    business = Businesses.get_business!(id)

    with {:ok, %Business{} = business} <- Businesses.update_business(business, business_params) do
      render(conn, "show.json", business: business)
    end
  end

  def delete(conn, %{"id" => id}) do
    business = Businesses.get_business!(id)

    with {:ok, %Business{}} <- Businesses.delete_business(business) do
      send_resp(conn, :no_content, "")
    end
  end
end
