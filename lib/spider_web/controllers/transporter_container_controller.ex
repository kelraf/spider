defmodule SpiderWeb.TransporterContainerController do
  use SpiderWeb, :controller

  alias Spider.Repo
  alias Spider.TransporterContainers
  alias Spider.TransporterContainers.TransporterContainer

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    transportercontainer = TransporterContainers.list_transportercontainer() |> Repo.preload(:transporters)
    render(conn, "index.json", transportercontainer: transportercontainer) 
  end

  def get_transporter_containers_using_business_id(conn, %{"business_id" => business_id}) do
    
    case TransporterContainers.get_transporter_containers_using_business_id(business_id) do
      {:empty, _nonses} ->
        conn
        |> json(%{
          message: "No Transport Containers Related To Your Business"
        })

      {:ok, transportercontainer} ->
        conn
        |> render("index.json", transportercontainer: transportercontainer)
        
    end

  end

  def create(conn, %{"transporter_container" => transporter_container_params}) do
    with {:ok, %TransporterContainer{} = transporter_container} <- TransporterContainers.create_transporter_container(transporter_container_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", transporter_container_path(conn, :show, transporter_container))
      |> render("show.json", transporter_container: transporter_container |> Repo.preload(:transporters))
    end
  end

  def show(conn, %{"id" => id}) do
    transporter_container = TransporterContainers.get_transporter_container!(id) |> Repo.preload(:transporters)
    render(conn, "show.json", transporter_container: transporter_container)
  end

  def update(conn, %{"id" => id, "transporter_container" => transporter_container_params}) do
    transporter_container = TransporterContainers.get_transporter_container!(id)

    with {:ok, %TransporterContainer{} = transporter_container} <- TransporterContainers.update_transporter_container(transporter_container, transporter_container_params) do
      render(conn, "show.json", transporter_container: transporter_container |> Repo.preload(:transporters))
    end
  end

  def delete(conn, %{"id" => id}) do
    transporter_container = TransporterContainers.get_transporter_container!(id)
    with {:ok, %TransporterContainer{}} <- TransporterContainers.delete_transporter_container(transporter_container) do
      send_resp(conn, :no_content, "")
    end
  end
end
