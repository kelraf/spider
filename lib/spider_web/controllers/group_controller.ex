defmodule SpiderWeb.GroupController do
  use SpiderWeb, :controller

  alias Spider.Groups
  alias Spider.Groups.Group

  action_fallback SpiderWeb.FallbackController

  def index(conn, _params) do
    groups = Groups.list_groups()
    render(conn, "index.json", groups: groups)
  end

  def get_group(conn, %{"business_id" => business_id}) do

    case Groups.get_group(business_id) do
      {:empty, message} ->
        conn
        |> put_status(:not_found)
        |> json(%{
          message: message
        })

      {:ok, group} ->
        group = group
        conn
        |> render("index.json", group: group)
    end
    
  end

  def create(conn, %{"group" => group_params}) do
    with {:ok, %Group{} = group} <- Groups.create_group(group_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", group_path(conn, :show, group))
      |> render("show.json", group: group)
    end
  end

  def show(conn, %{"id" => id}) do
    group = Groups.get_group!(id)
    render(conn, "show.json", group: group)
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    group = Groups.get_group!(id)

    with {:ok, %Group{} = group} <- Groups.update_group(group, group_params) do
      render(conn, "show.json", group: group)
    end
  end

  def delete(conn, %{"id" => id}) do
    group = Groups.get_group!(id)
    with {:ok, %Group{}} <- Groups.delete_group(group) do
      send_resp(conn, :no_content, "")
    end
  end

end
